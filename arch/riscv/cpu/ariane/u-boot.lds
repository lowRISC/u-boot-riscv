/*
 * Copyright (C) 2017 Andes Technology Corporation
 * Rick Chen, Andes Technology Corporation <rick@andestech.com>
 *
 * SPDX-License-Identifier:	GPL-2.0+
 */
OUTPUT_ARCH("riscv")
ENTRY(_start)

SECTIONS
{
	. = ALIGN(4);
	.text :
	{
		arch/riscv/cpu/ariane/start.o	(.text)
		*(.text)
	}

	. = ALIGN(4);
	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }

	. = ALIGN(4);
	.data : {
		__global_pointer$ = . + 0x800;
		*(.data*)
	}
	. = ALIGN(4);

	.got : {
	   __got_start = .;
	   *(.got.plt) *(.got)
	   __got_end = .;
    }

	. = ALIGN(4);

	.u_boot_list : {
		KEEP(*(SORT(.u_boot_list*)));
	}

    . = ALIGN(4);

    /DISCARD/ : { *(.rela.plt*) }
    .rela.dyn : {
        __rel_dyn_start = .;
        *(.rela*)
        __rel_dyn_end = .;
    }

    . = ALIGN(4);

    .dynsym : {
        __dyn_sym_start = .;
        *(.dynsym)
        __dyn_sym_end = .;
    }

    . = ALIGN(4);

	_end = .;

	.bss : {
        __bss_start = .;
        *(.bss)
		. = ALIGN(4);
		__bss_end = .;
	}

}
