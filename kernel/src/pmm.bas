#include once "stdlib.bi"
#include once "kernel.bi"
#include once "pmm.bi"
dim shared PageBitmap(0 to &h100000) as unsigned byte
dim shared TotalPagesCount	as unsigned integer
dim shared TotalFreePages	as unsigned integer
dim shared MemoryEnd as unsigned integer
dim shared KEND as unsigned byte ptr
dim shared FirstPage as unsigned integer
dim shared LastPage as unsigned integer

function PMM_GET_FREEPAGES_COUNT() as unsigned integer
    return TotalFreePages
end function

function PMM_GET_PAGES_COUNT() as unsigned integer
    return TotalPagesCount
end function

sub PMM_INIT()
    KWrite(@"Physical pages allocator initializing ...")
    MemoryEnd = &h100000000
	KEND = @_kernel_end
	
    FirstPage = (cuint(KEND) shr 12)+1
    LastPage = (MemoryEnd shr 12)
	
    for i as unsigned integer = 0 to &h100000
        PageBitmap(i)=0
    next i
    
    PMM_STRIPE(0,cuint(KEND))
    
    
    TotalPagesCount = 0
    for i as unsigned integer = 0 to &h100000
        if (PageBitmap(i)=0) then TotalPagesCount+=1
    next i
    TotalFreePages = TotalPagesCount
    KPrintOK()
    KNewLine()
    
    KWrite(@"UPER MEMORY      : ")
	KWrite(UIntToStr(MemoryEnd,10))
	KNewLine()
	KWrite(@"Availables free page : ")
	KWrite(UIntToStr(TotalFreePages,10))
	KNewLine()
end sub

'allocate a contigous number of pages
'it will mark the bitmap cells as used, and put the count in the first cell
'so it can free all pages when freeing the pages
function PMM_ALLOCPAGE() as any ptr
    
    dim i as unsigned integer
    i = FirstPage
    while i < LastPage
        if (PageBitmap(i)= 0) then
            PageBitmap(i)=1
            TotalFreePages-=1
            return cptr(any ptr,i shl 12)
        end if
        i+=1
    wend
    return 0
end function

'it will fre the pages at this address
'the parameter is the address of the first page
'in the bitmap , the value is the count of contigous pages allocated
function PMM_FREEPAGE(addr as any ptr) as unsigned integer
    if (addr<>0) then
        var idx = cuint(addr) shr 12
        if (PageBitmap(idx)=1) then
            PageBitmap(idx)=0
            TotalFreePages+=1
            return 1
        else
            KERROR(@"Physical page is not used",cuint(addr))
        end if
    end if
    return 0
end function


sub PMM_STRIPE(start_addr as unsigned integer,end_addr as unsigned integer)
    dim startPage	as unsigned integer = start_addr shr 12
    dim endPage		as unsigned integer = end_addr shr 12
    
    for i as unsigned integer = startPage to endPage
        PageBitmap(i) = &hFF
        TotalPagesCount-=1
        TotalFreePages-=1
    next
end sub