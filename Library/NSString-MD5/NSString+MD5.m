//
// NSString+MD5.m
// Originally created for MyFile
//
// Created by Árpád Goretity, 2011. Some infos were grabbed from StackOverflow.
// Released into the public domain. You can do whatever you want with this within the limits of applicable law (so nothing nasty!).
// I'm not responsible for any damage related to the use of this software. There's NO WARRANTY AT ALL.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

- (NSString *) MD5Hash {
	
    NSMutableData *hashData = [NSMutableData dataWithLength:CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(self.UTF8String,
           (CC_LONG)self.length,
           hashData.mutableBytes);
    
    NSMutableString *hashString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    const unsigned char *bytes = hashData.bytes;
    
    for(int i = 0; i < hashData.length; ++i)
        [hashString appendFormat:@"%02x", bytes[i]];
    
    return hashString;
	
}

@end

