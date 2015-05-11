//
//  Language.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/7/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "Language.h"

@implementation Language
static NSBundle *bundle = nil;
static NSString *currentLanguage;
+(void)initialize {
    //   NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    //    NSArray* languages = [defs objectForKey:@"AppleLanguages"]; anhnt6 comment
    //    NSString *current =@"vi";// [[languages objectAtIndex:0] retain];
    //    [self setLanguage:current];
    [self setLanguage:@"vi"];
}

+(void)setLanguage:(NSString *)l {
    currentLanguage=l;
    bundle = [NSBundle bundleWithPath:[[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ]];
}

+(NSString *)currentLanguage{
    return currentLanguage;
}
/*+(NSString *)fullLanguage{
 if ([currentLanguage isEqualToString:@"vi"]) {
 return @"vietnamese";
 } else if ([currentLanguage isEqualToString:@"en"]) {
 return @"english";
 }
 return @"english";
 }*/ //anhnt6 comment
+(NSString *)get:(NSString *)key alter:(NSString *)alternate {
    return [bundle localizedStringForKey:key value:alternate table:nil];
}
+(NSString *)get:(NSString *)key{
    return [bundle localizedStringForKey:key value:@"" table:nil];
}
+(int)getCodeTimeout{
    return -1;
}
@end
