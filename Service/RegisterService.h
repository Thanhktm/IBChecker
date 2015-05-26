//
//  RegisterService.h
//  IB Checker
//
//  Created by kienpt on 5/26/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"

@interface RegisterService : BaseService
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *key;

-(void) registerWithUsername:(NSString *)username phone:(NSString *)phone macAddress:(NSString *)macAddress;
@end
