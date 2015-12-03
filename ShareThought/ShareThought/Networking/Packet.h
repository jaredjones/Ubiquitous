//
//  Packet.h
//  Sharethought
//
//  Created by Jared Jones on 10/19/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#ifndef _H_SHARETHOUGHT_Packet_H
#define _H_SHARETHOUGHT_Packet_H

#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
typedef struct Packet
{
    uint8_t OPCODE;
    uint32_t LENGTH;
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

//Construct Packet Byte Array Given Opcode, Length, and Data
char* ConstructPacket(uint8_t op, uint32_t length, char* data, uint64_t* finalPacketSize)
{
    uint64_t finalSize = sizeof(op) + sizeof(uint32_t) + length;
    *finalPacketSize = finalSize;
    char* finalPacket = (char*)calloc((uint32_t)finalSize, 1);
    
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

Packet* DecodePacket(char *buff, uint64_t size)
{
    Packet *tmp = malloc(sizeof(Packet));
    tmp->OPCODE = *buff;
    
    tmp->LENGTH = *((uint32_t*) (buff + 1));
    if (size < 5)
        size = 5;
    tmp->DATA = (char*)calloc((uint32_t)size - 5, 1);
    
    int i;
    for (i = 5; i < size; i++)
        *(tmp->DATA + i - 5) = *(buff + i);
    return tmp;
}

#endif /* _H_SHARETHOUGHT_Packet_H */
