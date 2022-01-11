.global _binary_font_bin_start
.global _binary_font_bin_end
.section .data
_binary_font_bin_start:
.incbin "font.bin"
_binary_font_bin_end: