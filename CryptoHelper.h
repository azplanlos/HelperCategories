//
//  CryptoHelper.h
//  Cloud Backup Agent
//
//  Created by Andreas Zöllner on 21.07.15.
//  Copyright (c) 2015 Studio Istanbul Medya Hiz. Tic. Ltd. Sti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptoHelper : NSObject
+(NSData *)sha1:(NSData *)data;
+(NSData *)sha256:(NSData *)data;
+(NSString *)hmac:(NSString *)plainText withKey:(NSString *)key;
+(NSData*)hmacData:(NSData*)plainData withKey:(NSString*)key;
+(NSData*)hmac:(NSString*)plainText withDataKey:(NSData*)dataKey;
@end
