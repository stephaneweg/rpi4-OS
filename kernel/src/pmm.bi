declare sub PMM_INIT()
declare sub PMM_STRIPE(start_addr as unsigned integer,end_addr as unsigned integer)
declare function PMM_GET_FREEPAGES_COUNT() as unsigned integer
declare function PMM_GET_PAGES_COUNT() as unsigned integer
declare function PMM_ALLOCPAGE() as any ptr