//
//  Packet.h
//  Sharethought
//
//  Created by Jared Jones on 10/19/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#ifndef Packet_h
#define Packet_h

#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
typedef struct Packet
{
    uint8_t OPCODE;
    uint16_t LENGTH;
    char* DATA;
}Packet;
#pragma pack(pop)

#define CMSG_KEEP_ALIVE         0x01
#define SMSG_KEEP_ALIVE         0x02

//Construct Packet Byte Array Given Opcode, Length, and Data
char* ConstructPacket(uint8_t op, uint16_t length, char* data, uint64_t* finalPacketSize)
{
    uint64_t finalSize = sizeof(op) + sizeof(uint16_t) + length;
    *finalPacketSize = finalSize;
    char* finalPacket = (char*)calloc(finalSize, 1);
    
    int i;
    for (i = 0; i < finalSize; i++)
    {
        if (i == 0)
        {
            *(finalPacket + 0) = op;
            *(finalPacket + 1) = (uint8_t)(length & 0x00FF);
            *(finalPacket + 2) = (uint8_t)((length & 0xFF00) >> 8);
            i = 2;
            continue;
        }
        
        *(finalPacket + i) = *(data + i - 3);
    }
    return finalPacket;
}

Packet* DecodePacket(char *buff, uint64_t size)
{
    Packet *tmp = malloc(sizeof(Packet));
    tmp->OPCODE = *buff;
    
    tmp->LENGTH = *(buff + 1);
    tmp->LENGTH = tmp->LENGTH | (*(buff + 2) << 8);
    
    tmp->DATA = (char*)calloc(size - 3, 1);
    
    int i;
    for (i = 3; i < size; i++)
        *(tmp->DATA + i - 3) = *(buff + i);
    return tmp;
}

#endif /* Packet_h */
