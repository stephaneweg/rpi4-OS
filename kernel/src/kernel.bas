
#include once "kernel.bi"
#include once "stdlib.bi"
#include once "pmm.bi"
#include once "graphics/font.bi"
#include once "graphics/gbuffer.bi"
#include once "graphics/graphic_console.bi"

declare sub main cdecl alias "main" ()
declare sub wait_cycles cdecl alias "wait_cycles" (n as unsigned integer)
declare sub uart_init cdecl alias "uart_init" ()
declare sub uart_send cdecl alias "uart_send" (c as unsigned integer)
declare function uart_getc cdecl alias "uart_getc" () as unsigned byte
declare sub lfb_init cdecl alias "lfb_init" ()
declare sub lfb_showpicture cdecl alias "lfb_showpicture" ()
declare sub lfb_info  cdecl alias "lfb_info" (lfbaddr as unsigned long ptr ptr,_width as unsigned integer ptr,height as unsigned integer ptr)




dim shared CONSOLE			as GRAPHIC_CONSOLE


sub main cdecl alias "main" ()

	dim _lfb as unsigned long ptr
	dim _w as unsigned integer
	dim _h as unsigned integer 
	uart_init()
    lfb_init()

	lfb_info(@_lfb,@_w,@_h)
	CONSOLE.init(_lfb,_w,_h)
	CONSOLE.FOREGROUND = &h0000FF
	CONSOLE.WriteLine(@"Booting Onyx Version 0.0.1")
	CONSOLE.FOREGROUND = &hEEEEEE
	PMM_INIT()
	
    lfb_showpicture()
	dim b as unsigned byte = 32
    do
		Console.PutChar(asc("."))
		wait_cycles(1000000)
    loop
end sub

sub KWRITELINE(_s as unsigned byte ptr)
	CONSOLE.WriteLine(_s)
end sub

sub KERROR(_s as unsigned byte ptr, _code as unsigned integer)
	CONSOLE.FOREGROUND =&hFF0000
	CONSOLE.WriteLine(_s)
	CONSOLE.WRITE(@"Code : 0x")
	Console.Write(UIntToStr(_code,16))
	do:loop
end sub

sub KWRITE(_s as unsigned byte ptr)
	CONSOLE.Write(_s)
end sub

sub KNewLine()
	CONSOLE.NewLine()
end sub

sub KPrintOK()
	Console.PrintOK()
end sub