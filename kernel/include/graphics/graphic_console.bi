#include once "graphics/gbuffer.bi"
TYPE GRAPHIC_CONSOLE extends GBUFFER field=1
	CursorX 		as integer
	CursorY 		as integer
	ConsoleWidth	as integer
	ConsoleHeight	as integer
	Foreground as unsigned long
	Background as unsigned long
	declare sub Init(_buffer as unsigned long ptr,_width as unsigned integer,_height as unsigned integer)
	declare sub Clear()
	declare sub PutChar(_b as unsigned byte)
	declare sub Write(_s as unsigned byte ptr)
	declare sub WriteLine(_s as unsigned byte ptr)
	declare sub NewLine()
	declare sub BackSpace()
	declare sub Scroll()
	declare sub PrintOK()
end type