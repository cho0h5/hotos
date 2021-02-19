
void main()
{
    char WELCOMEMESSAGE[] = "Welcome to C";
    short *video = 0xB8000;
    video += 80 * 3 + 0;
    for (int i = 0; WELCOMEMESSAGE[i] != 0; i++, video++) {
        *video = (*(video) & 0xFF00) | WELCOMEMESSAGE[i];
    }

    while (1)
    {
    }
}