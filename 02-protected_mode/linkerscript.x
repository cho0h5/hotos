SECTIONS
{
    . = 0x10200;
    .text : { *(.text .text.*) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}