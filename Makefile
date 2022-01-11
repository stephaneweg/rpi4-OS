CC = aarch64-none-elf-gcc
AS = aarch64-none-elf-as
LD = aarch64-none-elf-ld
OBJCOPY = aarch64-none-elf-objcopy
FBC = fbc
FBCFLAGS = -nodeflibs -lang fb -arch aarch64 -i kernel/include
CFLAGS = -ffreestanding -O2 -Wall -nostdinc -nostdlib -nostartfiles -I ./kernel/include
AS_CFLAGS = -ffreestanding -O2 -Wall -nostdinc -nostdlib -nostartfiles
SRCS_KERNEL  =
SRCS_KERNEL += $(shell find kernel/src/ -name *.S)
SRCS_KERNEL += $(shell find kernel/src/ -name *.c)
SRCS_KERNEL += $(shell find kernel/src/ -name *.bas)
OBJS_KERNEL = $(addsuffix .o,$(basename $(SRCS_KERNEL)))
KERNEL_ELF	= kernel.elf

kernel: $(KERNEL_ELF)
	$(OBJCOPY) $(KERNEL_ELF) -O binary kernel8.img
	
kernel.elf: $(OBJS_KERNEL)
	$(LD) -T kernel/kernel.ld -o kernel.elf -O2 -nostdlib $(OBJS_KERNEL)

%.o: %.S
	$(CC) $(AS_CFLAGS) -c $^ -o $@
	
%.o: %.bas
	$(FBC) -c $(FBCFLAGS) $^ -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

clean:cleanobj
	rm $(KERNEL_ELF) *.img
cleanobj: 
	rm $(OBJS_KERNEL)

