TYPE GBUFFER field=1
	BUFFER 	as unsigned long ptr
	WIDTH	as unsigned integer
	HEIGHT	as unsigned integer
	
	declare sub SET_PIXEL(_x as unsigned integer,_y as unsigned integer,_c as unsigned long)
	declare sub DRAW_CHAR(_b as unsigned byte,_x1 as integer,_y1 as integer,_c as unsigned long)
	declare sub DRAW_STRING(_txt as unsigned byte ptr,_x1 as integer,_y1 as integer,_c as unsigned long)
	declare sub Clear(_c as unsigned long)
end type