#ifndef SHARETHOUGHT_SERVER_PACKET_H
#define SHARETHOUGHT_SERVER_PACKET_H

#include <stdlib.h>
#include <string.h>

#pragma pack(push, 1)
typedef struct Packet
{
    uint8 OPCODE;
    uint16 LENGTH;
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
unsigned char* ConstructPacket(uint8 op, uint16 length, unsigned char* data, uint64* finalPacketSize)
{
    uint64 finalSize = sizeof(op) + sizeof(uint16) + length;
    *finalPacketSize = finalSize;
    unsigned char* finalPacket = (unsigned char*)calloc(finalSize, 1);
    
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

Packet DecodePacket(unsigned char *buff, uint64 size)
{
    Packet tmp;
    tmp.OPCODE = *buff;
    
    tmp.LENGTH = *(buff + 1);
    tmp.LENGTH = tmp.LENGTH | (*(buff + 2) << 8);
    
    tmp.DATA = (unsigned char*)calloc(size - 3, 1);
    
    int i;
    for (i = 3; i < size; i++)
        *(tmp.DATA + i - 3) = *(buff + i);
    return tmp;
}

#endif