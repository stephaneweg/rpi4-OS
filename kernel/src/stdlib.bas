#include once "stdlib.bi"
static shared Result(0 to 2047) as unsigned byte
static shared Result2(0 to 2047) as unsigned byte


function strlen(s as unsigned byte ptr) as unsigned integer
    dim retval as unsigned integer
    retval=0
    while s[retval]<>0
        retval+=1
    wend
    return retval
end function

sub strrev(s as unsigned byte ptr)
    
    dim l as integer=strlen(s)
    dim i as integer
    dim tmp as unsigned byte
    dim tmp2 as unsigned byte
    for i=0 to (l/2)-1
        tmp=s[i]
        tmp2=s[l-i-1]
        s[i] = tmp2
        s[l-i-1]=tmp
    next i
end sub

function UIntToStr (number as unsigned integer,abase as unsigned integer) as unsigned byte ptr
    dim buffer as unsigned byte ptr
    dim dst as unsigned byte ptr=@(Result(0))
    dim i as  unsigned integer=number
    dim l as unsigned integer=0
    dim n as unsigned integer
    if (i=0) then
        dst[0]=48
        dst[1]=0
        return dst
    end if
    
    
    while (i>0)
        n = i mod abase
        if (n<10) then
            dst[l]=n+48
        else
            dst[l]=n+55
        end if
        i=(i - n)/abase
        l+=1
    wend
    dst[l]=0
    strrev(dst)
    return dst
end function

sub MemSet64(_dst as unsigned longint ptr,_value as unsigned longint,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_value
	next
end sub
	
sub MemSet32(_dst as unsigned long ptr,_value as unsigned long,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_value
	next
end sub

sub MemSet16(_dst as unsigned short ptr,_value as unsigned short,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_value
	next
end sub

sub MemSet(_dst as unsigned byte ptr,_value as unsigned byte,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_value
	next
end sub

sub MemCpy64(_dst as unsigned longint ptr,_src as unsigned longint ptr,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_src[i]
	next
end sub

sub MemCpy32(_dst as unsigned long ptr,_src as unsigned long ptr,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_src[i]
	next
end sub

sub MemCpy16(_dst as unsigned short ptr,_src as unsigned short ptr,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_src[i]
	next
end sub

sub MemCpy(_dst as unsigned byte ptr,_src as unsigned byte ptr,_count as unsigned integer)
	if (_count<0) then exit sub
	dim _last as unsigned integer = _count-1
	
	for i as unsigned integer = 0 to _last
		_dst[i]=_src[i]
	next
end sub