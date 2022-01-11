#include once "graphics/gbuffer.bi"
#include once "graphics/font.bi"
#include once "stdlib.bi"
sub GBUFFER.SET_PIXEL(_x as unsigned integer,_y as unsigned integer,_c as unsigned long)
	if (_x>=0 and _y>=0 and _x<this.WIDTH and _y<this.HEIGHT) then
		this.BUFFER[_y * this.WIDTH + _x] = _c
	end if
end sub

sub GBUFFER.DRAW_STRING(_txt as unsigned byte ptr,_x1 as integer,_y1 as integer,_c as unsigned long)
	dim txtp as unsigned byte ptr = _txt
	dim tx as integer = _x1
	
	while *txtp<>0
		DRAW_CHAR(*txtp,tx,_y1,_c)
		tx+=8
		txtp+=1
	wend
end sub

sub GBUFFER.DRAW_CHAR(_b as unsigned byte,_x1 as integer,_y1 as integer,_c as unsigned long)
	dim rowNum as integer
    dim colNum as integer
	dim x as integer
	dim y as integer
	dim font_bin as unsigned byte ptr= @font_bin_start
	dim bData as unsigned byte
	
	
	for rowNum=0 to 7
		bdata=font_bin[_b * 8 + rowNum]
		for colNum = 0 to 7
			if ((bData shr colNum) and &h1)=&h1 then
				x = _x1+7-colNum
				y = _y1+rowNum
				SET_PIXEL(x,y,_c)
			end if
		next
	next
end sub

sub GBUFFER.Clear(_c as unsigned long)
	MemSet32(this.BUFFER,_c,this.WIDTH*this.Height)
end sub