SECTIONS
{
    . = 0x10200;
    .text : { *(.text*) }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}