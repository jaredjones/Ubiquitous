//
//  Packet.h
//  Sharethought
//
//  Created by Jared Jones on 10/19/15.
//  Copyright © 2015 Team7. All rights reserved.
//

#ifndef _H_SHARETHOUGHT_Packet_H
#define _H_SHARETHOUGHT_Packet_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
typedef struct Packet
{
    uint8_t OPCODE;
    uint16_t LENGTH;
    unsigned char* DATA;
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
#define CMSG_GRAB_CONTACTS              0x0b
#define SMSG_SEND_CONTACTS              0x0c
#define CMSG_DELETE_ACCOUNT             0x0d
#define CMSG_ADD_CONTACT                0x0e
#define SMSG_SEND_MESSAGE_TO_PROFILE    0x0f
#define CMSG_DELETE_CONTACT             0x10
#define CMSG_SEND_CHAT_MESSAGE          0x11
#define SMSG_SEND_CHAT_MESSAGE          0x12

//Construct Packet Byte Array Given Opcode, Length, and Data
unsigned char* ConstructPacket(uint8_t op, uint16_t length, unsigned char* data, uint64_t* finalPacketSize)
{
    uint64_t finalSize = sizeof(op) + sizeof(uint16_t) + length;
    *finalPacketSize = finalSize;
    unsigned char* finalPacket = (unsigned char*)calloc((uint32_t)finalSize, 1);
    
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

Packet* DecodePacket(unsigned char *buff, uint64_t size)
{
    Packet *tmp = malloc(sizeof(Packet));
    tmp->OPCODE = *buff;
    
    tmp->LENGTH = *(buff + 1);
    tmp->LENGTH = tmp->LENGTH | (*(buff + 2) << 8);
    
    tmp->DATA = (unsigned char*)calloc((uint32_t)size - 3, 1);
    
    int i;
    for (i = 3; i < size; i++)
        *(tmp->DATA + i - 3) = *(buff + i);
    return tmp;
}

#endif /* _H_SHARETHOUGHT_Packet_H */
