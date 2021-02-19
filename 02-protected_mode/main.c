#include "type.h"

void print_message(int x, int y, char *message);

void main()
{
    print_message(0, 4, "Welcome to C");

    while (1)
        ;
}

void print_message(int x, int y, char *message)
{
    CHARACTER *video = 0xB8000;
    video += 80 * y + x;
    video->character = 'c';

    for (int i = 0; i < 12; i++)
    {
        video[i].character = message[i];
    }
}