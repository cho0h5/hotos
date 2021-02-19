#ifndef TYPE_H
#define TYPE_H

#define u8   unsigned char
#define u16  unsigned short
#define u32  unsigned int
#define u64  unsigned long
#define bool unsigned char

#define TRUE  1
#define FALSE 0

#pragma pack(push, 1)

typedef struct _CHARACTER {
    u8 character;
    u8 attribute;
} CHARACTER;

#pragma pack(pop)

#endif