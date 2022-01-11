#include once "graphics/gbuffer.bi"
#include once "graphics/graphic_console.bi"
#include once "stdlib.bi"


sub GRAPHIC_CONSOLE.Init(_buffer as unsigned long ptr,_width as unsigned integer,_height as unsigned integer)
	this.BUFFER			= _buffer
	this.WIDTH			= _width
	this.HEIGHT			= _height
	this.CursorX 		= 0
	this.CursorY		= 0
	this.Foreground		= &hFFFFFF
	this.Background		= &h000000
	this.ConsoleWidth	= _width/8
	this.ConsoleHeight	= _height/9
	this.Clear()
	this.WriteLine(@"Console Ready")
end sub

sub GRAPHIC_CONSOLE.Clear()
	cptr(GBUFFER ptr,@this)->Clear(this.Background)
	this.CursorX	= 0
	this.CursorY	= 0
end sub

sub GRAPHIC_CONSOLE.PrintOK()
	this.DRAW_CHAR(asc("["),(this.ConsoleWidth-7)*8,this.ConsoleHeight*9,&h0000FF)
	this.DRAW_CHAR(asc("O"),(this.ConsoleWidth-5)*8,this.ConsoleHeight*9,&h00FF00)
	this.DRAW_CHAR(asc("K"),(this.ConsoleWidth-4)*8,this.ConsoleHeight*9,&h00FF00)
	this.DRAW_CHAR(asc("]"),(this.ConsoleWidth-2)*8,this.ConsoleHeight*9,&h0000FF)
end sub

sub GRAPHIC_CONSOLE.PutChar(_b as unsigned byte)
	if (_b)=13 then exit sub
	if (_b=10) then
		this.NewLine()
		exit sub
	end if
	if (_b=8) then
		this.BackSpace()
	end if
	if (_b=9) then
		CursorX += 5-(CursorX mod 5)
		if (CursorX>=ConsoleWidth) then NewLine()
	else
		this.DRAW_CHAR(_b,CursorX*8,CursorY*9,Foreground)
		CursorX+=1
	end if
	
	if (CursorX>=ConsoleWidth) then
		NewLine()
	end if
end sub

sub GRAPHIC_CONSOLE.Write(_s as unsigned byte ptr)
	dim cpt as unsigned integer
	while _s[cpt]<>0
		PutChar(_s[cpt])
		cpt+=1
	wend
end sub

sub GRAPHIC_CONSOLE.WriteLine(_s as unsigned byte ptr)
	Write(_s)
	NewLine()
end sub

sub GRAPHIC_CONSOLE.NewLine()
    CursorX=0
    CursorY+=1
    if (CursorY>=ConsoleHeight) then Scroll()
end sub

sub GRAPHIC_CONSOLE.Scroll()
	dim dst_start as unsigned integer		= cuint(this.BUFFER)
	dim row_size as unsigned integer		= this.WIDTH*9*4
	dim count_to_copy as unsigned integer	= (this.WIDTH*(this.HEIGHT-9)*4)
	dim dst_end as unsigned integer			= dst_start+count_to_copy
	
	MemCpy32(this.BUFFER,cptr(unsigned long ptr,dst_start+row_size),count_to_copy shr 2)
	MemSet32(cptr(unsigned long ptr,dst_end),this.Background,row_size shr 2)
	
	
	'dim src as unsigned integer			= cuint(this.BUFFER)+this.WIDTH*9*4
	'dim dst_end as unsigned integer		= dst_start+this.WIDTH*(this.HEIGHT-9)*4
	'dim dst_end_end as unsigned integer = dst_end+this.WIDTH*9*4
	
	'while dst_start<dst_end
	'	*cptr(unsigned long ptr,dst_start)=*cptr(unsigned long ptr,src)
	'	src+=4
	'	dst_start+=4
	'wend
	
	'while dst_start<dst_end_end
	'	*cptr(unsigned long ptr,dst_start)=this.Background
	'	dst_start+=4
	'wend
    CursorY-=1
end sub

sub GRAPHIC_CONSOLE.BackSpace()
end sub

