//
//  CryptoHelper.m
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 21.07.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import "CryptoHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import "../Base64/Base64/MF_Base64Additions.h"

@implementation CryptoHelper

+(NSData*)md5:(NSData *)data {
    uint8_t output[CC_MD5_DIGEST_LENGTH]; CC_MD5(data.bytes, (int)data.length, output);
    NSData *checksum = [NSData dataWithBytes:output length:CC_MD5_DIGEST_LENGTH];
    return checksum;
}

+(NSString*)md5Base64String:(NSString *)inputString {
    return [[CryptoHelper md5:[inputString dataUsingEncoding:NSUTF8StringEncoding]] base64String];
}

+ (NSData *)sha1:(NSData *)data {
    unsigned char hash[CC_SHA1_DIGEST_LENGTH];
    if ( CC_SHA1([data bytes], (int)[data length], hash) ) {
        NSData *sha1 = [NSData dataWithBytes:hash length:CC_SHA1_DIGEST_LENGTH];
        return sha1;
    }
    return nil;
}

+ (NSData *)sha256:(NSData *)data {
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    if ( CC_SHA256([data bytes], (int)[data length], hash) ) {
        NSData *sha1 = [NSData dataWithBytes:hash length:CC_SHA256_DIGEST_LENGTH];
        return sha1;
    }
    return nil;
}

+(NSString*)sha256HexString:(NSData *)data {
    NSString* sha256 = @"";
    NSData* sha256Data = [self sha256:data];
    const unsigned char *buffer = (const unsigned char *)[sha256Data bytes];
    for (int i = 0; i < sha256Data.length; i++) {
        sha256 = [sha256 stringByAppendingFormat:@"%02lx", (unsigned long)buffer[i]];
    }
    return sha256;
}

+(NSString *)hmac:(NSString *)plainText withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [plainText cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMACData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    
    for (int i = 0; i < HMACData.length; ++i)
        HMAC = [HMAC stringByAppendingFormat:@"%02lx", (unsigned long)buffer[i]];
    
    return HMAC;
}

+(NSData*)hmacData:(NSData *)plainData withKey:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), plainData.bytes, plainData.length, cHMAC);
    return [NSData dataWithBytes:cHMAC length:CC_SHA256_DIGEST_LENGTH];
}

+(NSData*)hmac:(NSString *)plainText withDataKey:(NSData *)dataKey {
    const char *cData = [plainText cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, dataKey.bytes, dataKey.length, cData, strlen(cData), cHMAC);
    
    NSData *HMACData = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return HMACData;
}

// Makes a random 256-bit salt
+(NSData*)generateSalt256 {
    unsigned char salt[32];
    for (int i=0; i<32; i++) {
        salt[i] = (unsigned char)arc4random();
    }
    return [NSData dataWithBytes:salt length:32];
}

+(int)hashRoundsForPWLength:(int)pwLength andSaltLength:(int)saltLength maxDuration:(NSTimeInterval)duration {
    int rounds = CCCalibratePBKDF(kCCPBKDF2, pwLength,
                                  saltLength, kCCPRFHmacAlgSHA256, 32, duration*1000);
    return rounds;
}

+(NSData*)createSHA256KeyWithPassphrase:(NSString *)myPass andSalt:(NSData *)salt andRounds:(int)iterations {
    // Make keys!
    NSData* myPassData = [myPass dataUsingEncoding:NSUTF8StringEncoding];
        
    // Open CommonKeyDerivation.h for help
    unsigned char key[32];
    CCKeyDerivationPBKDF(kCCPBKDF2, myPassData.bytes, myPassData.length,
                         salt.bytes, salt.length, kCCPRFHmacAlgSHA256, iterations, key, 32);
    NSData* keyData = [NSData dataWithBytes:key length:32];
    return keyData;
}

+(NSData*)createSHA256KeyWithPassphrase:(NSString*)myPass {
    NSData* salt = [CryptoHelper generateSalt256];
    int rounds = [CryptoHelper hashRoundsForPWLength:(int)myPass.length andSaltLength:(int)salt.length maxDuration:1];
    return [CryptoHelper createSHA256KeyWithPassphrase:myPass andSalt:salt andRounds:rounds];
}


@end
