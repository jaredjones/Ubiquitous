#ifndef SHARETHOUGHT_SERVER_PACKET_H
#define SHARETHOUGHT_SERVER_PACKET_H

#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
typedef struct Packet
{
    uint8 OPCODE;
    uint32 LENGTH;
    char* DATA;
}Packet;
#pragma pack(pop)

#define CMSG_KEEP_ALIVE                 0x01
#define SMSG_KEEP_ALIVE                 0x02
#define SMSG_CONNECTED                  0x03
#define CMSG_LOGIN                      0x04
#define CMSG_REGISTER                   0x05
#define SMSG_SUCCESSFUL_LOGIN           0x06
#define SMSG_UNSUCCESSFUL_LOGIN         0x07
#define SMSG_ACCOUNT_CREATED            0x08
#define SMSG_ACCOUNT_ALREADY_EXISTS     0x09
#define CMSG_LOGOUT                     0x0a
#define CMSG_UPDATE_PICTURE             0x0b
#define CMSG_UPDATE_PICTURE_CONT        0x0c

//Construct Packet Byte Array Given Opcode, Length, and Data
char* ConstructPacket(uint8 op, uint32 length, char* data, uint64* finalPacketSize)
{
    uint64 finalSize = sizeof(op) + sizeof(uint32) + length;
    *finalPacketSize = finalSize;
    char* finalPacket = (char*)calloc(finalSize, 1);
    
    int i;
    for (i = 0; i < finalSize; i++)
    {
        if (i == 0)
        {
            *(finalPacket + 0) = op;
            *(finalPacket + 1) = (uint8_t)(length & 0x000000FF);
            *(finalPacket + 2) = (uint8_t)((length & 0x0000FF00) >> 8);
            *(finalPacket + 3) = (uint8_t)((length & 0x00FF0000) >> 16);
            *(finalPacket + 4) = (uint8_t)((length & 0xFF000000) >> 24);
            i = 4;
            continue;
        }
        
        *(finalPacket + i) = *(data + i - 5);
    }
    return finalPacket;
}

Packet DecodePacket(char *buff, uint64 size)
{
    Packet tmp;
    tmp.OPCODE = *buff;
    tmp.LENGTH = *((uint32_t*) (buff + 1));
    
    tmp.DATA = (char*)calloc(size - 3, 1);
    
    int i;
    for (i = 5; i < size; i++)
        *(tmp.DATA + i - 5) = *(buff + i);
    return tmp;
}

#endif