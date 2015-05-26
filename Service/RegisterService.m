//
//  RegisterService.m
//  IB Checker
//
//  Created by kienpt on 5/26/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "RegisterService.h"
#import "Item.h"

@implementation RegisterService
-(void) registerWithUsername:(NSString *) username phone:(NSString *) phone macAddress:(NSString *) macAddress {
    NSDictionary *params = @{@"userName":username, @"mobilePhone":phone, @"macAddress":macAddress};
    [self post:@"/public/register" params:params];
    _username = username;
}

-(BOOL)parser:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    _key = [data stringForKey:@"content"];
    return YES;
}
@end
