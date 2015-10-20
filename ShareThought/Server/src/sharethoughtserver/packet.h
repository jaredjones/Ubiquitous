#ifndef SHARETHOUGHT_SERVER_PACKET_H
#define SHARETHOUGHT_SERVER_PACKET_H

#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
typedef struct Packet
{
    uint8 OPCODE;
    uint16 LENGTH;
    char* DATA;
}Packet;
#pragma pack(pop)

#define CMSG_KEEP_ALIVE         0x01
#define SMSG_KEEP_ALIVE         0x02
#define SMSG_CONNECTED          0x03

//Construct Packet Byte Array Given Opcode, Length, and Data
char* ConstructPacket(uint8 op, uint16 length, char* data, uint64* finalPacketSize)
{
    uint64 finalSize = sizeof(op) + sizeof(uint16) + length;
    *finalPacketSize = finalSize;
    char* finalPacket = (char*)calloc(finalSize, 1);
    
    int i;
    for (i = 0; i < finalSize; i++)
    {
        if (i == 0)
        {
            *(finalPacket + 0) = op;
            *(finalPacket + 1) = (uint8)(length & 0x00FF);
            *(finalPacket + 2) = (uint8)((length & 0xFF00) >> 8);
            i = 2;
            continue;
        }
        
        *(finalPacket + i) = *(data + i - 3);
    }
    return finalPacket;
}

Packet DecodePacket(char *buff, uint64 size)
{
    Packet tmp;
    tmp.OPCODE = *buff;
    
    tmp.LENGTH = *(buff + 1);
    tmp.LENGTH = tmp.LENGTH | (*(buff + 2) << 8);
    
    tmp.DATA = (char*)calloc(size - 3, 1);
    
    int i;
    for (i = 3; i < size; i++)
        *(tmp.DATA + i - 3) = *(buff + i);
    return tmp;
}

#endif