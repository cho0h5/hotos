#include "type.h"

void print_message(int x, int y, char *message);
bool is_enough_memory();

void main()
{
    print_message(0, 3, "Welcome to C");
    print_message(0, 4, "[      ] Memory Size Enough Check");
    if (is_enough_memory())
        print_message(2, 4, "Pass");
    else
        print_message(2, 4, "Fail");

    while (1)
        ;
}

void print_message(int x, int y, char *message)
{
    CHARACTER *video = 0xB8000;
    video += 80 * y + x;
    video->character = 'c';

    for (int i = 0; message[i] != 0; i++)
    {
        video[i].character = message[i];
    }
}

bool is_enough_memory()
{
    for (u32 *addr = 0x100000; addr < 0x4000000; addr += 0x100000)
    {
        *addr = 0x01234567;
        if (*addr != 0x01234567)
            return FALSE;
    }
    return TRUE;
}