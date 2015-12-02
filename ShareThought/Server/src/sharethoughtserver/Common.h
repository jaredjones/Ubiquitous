//
//  Common.h
//  ShareThough_Server
//
//  Created by Jared Jones on 12/1/15.
//
//

#ifndef Common_h
#define Common_h


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if defined(__APPLE__)
#  define COMMON_DIGEST_FOR_OPENSSL
#  include <CommonCrypto/CommonDigest.h>
#  define SHA1 CC_SHA1
#else
#  include <openssl/md5.h>
#endif

char *str2md5(const char *str, int length) {
    int n;
    MD5_CTX c;
    unsigned char digest[16];
    char *out = (char*)malloc(33);
    
    MD5_Init(&c);
    
    while (length > 0) {
        if (length > 512) {
            MD5_Update(&c, str, 512);
        } else {
            MD5_Update(&c, str, length);
        }
        length -= 512;
        str += 512;
    }
    
    MD5_Final(digest, &c);
    
    for (n = 0; n < 16; ++n) {
        snprintf(&(out[n*2]), 16*2, "%02x", (unsigned int)digest[n]);
    }
    return out;
}

char *generateguid(){
    srand (clock());
    char *GUID = (char*)malloc(40);
    int t = 0;
    const char *szTemp = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx";
    const char *szHex = "0123456789ABCDEF-";
    int nLen = strlen (szTemp);
    
    for (t=0; t<nLen+1; t++)
    {
        int r = rand () % 16;
        char c = ' ';
        
        switch (szTemp[t])
        {
            case 'x' : { c = szHex [r]; } break;
            case 'y' : { c = szHex [(r & 0x03) | 0x08]; } break;
            case '-' : { c = '-'; } break;
            case '4' : { c = '4'; } break;
        }
        
        GUID[t] = ( t < nLen ) ? c : 0x00;
    }
    return GUID;
}

#endif /* Common_h */
