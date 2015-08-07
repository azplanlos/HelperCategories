//
//  CryptoHelper.h
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 21.07.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptoHelper : NSObject
+(NSData*)md5:(NSData*)data;
+(NSString*)md5Base64String:(NSString*)inputString;
+(NSString*)md5Base64StringFromData:(NSData *)inputData;
+(NSData *)sha1:(NSData *)data;
+(NSData *)sha256:(NSData *)data;
+(NSString*)sha256HexString:(NSData*)data;
+(NSString *)hmac:(NSString *)plainText withKey:(NSString *)key;
+(NSData*)hmacData:(NSData*)plainData withKey:(NSString*)key;
+(NSData*)hmac:(NSString*)plainText withDataKey:(NSData*)dataKey;
+(NSData*)createSHA256KeyWithPassphrase:(NSString*)myPass;
+(NSData*)createSHA256KeyWithPassphrase:(NSString *)myPass andSalt:(NSData *)salt andRounds:(int)iterations;
+(NSData*)generateSalt256;
+(int)hashRoundsForPWLength:(int)pwLength andSaltLength:(int)saltLength maxDuration:(NSTimeInterval)duration;
@end
