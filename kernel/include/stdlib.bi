declare function UIntToStr (number as unsigned integer,abase as unsigned integer) as unsigned byte ptr
declare sub strrev(s as unsigned byte ptr)
declare function strlen(s as unsigned byte ptr) as unsigned integer

declare sub MemSet64(_dst as unsigned longint ptr,_value as unsigned longint,_count as unsigned integer)
declare sub MemSet32(_dst as unsigned long ptr,_value as unsigned long,_count as unsigned integer)
declare sub MemSet16(_dst as unsigned short ptr,_value as unsigned short,_count as unsigned integer)
declare sub MemSet(_dst as unsigned byte ptr,_value as unsigned byte,_count as unsigned integer)

declare sub MemCpy64(_dst as unsigned longint ptr,_src as unsigned longint ptr,_count as unsigned integer)
declare sub MemCpy32(_dst as unsigned long ptr,_src as unsigned long ptr,_count as unsigned integer)
declare sub MemCpy16(_dst as unsigned short ptr,_src as unsigned short ptr,_count as unsigned integer)
declare sub MemCpy(_dst as unsigned byte ptr,_src as unsigned byte ptr,_count as unsigned integer)