SECTIONS
{
    . = 0x10200;
    .text : { *(.text) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}
