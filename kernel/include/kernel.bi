declare sub KWriteLine(_s as unsigned byte ptr)
declare sub KWrite(_s as unsigned byte ptr)
declare sub KError(_s as unsigned byte ptr, _code as unsigned integer)
declare sub KNewLine()
declare sub KPrintOK()

extern _kernel_start	alias "_kernel_start" as byte
extern _kernel_end	 	alias "_kernel_end" as byte
