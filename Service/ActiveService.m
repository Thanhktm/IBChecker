//
//  ActiveService.m
//  IB Checker
//
//  Created by kienpt on 5/26/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "ActiveService.h"
#import "Item.h"
@implementation ActiveService
-(void) activeWithCode:(NSString *) code key:(NSString *)key {
    NSDictionary *params = @{@"key":key, @"activeCode":code};
    [self post:@"/public/activeUser" params:params];
}

-(BOOL)parser:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    
    return YES;
}
@end
