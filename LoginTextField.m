//
//  LoginTextField.m
//  IB Checker
//
//  Created by Thanh on 5/26/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

//here 40 - is your x offset
- (CGRect)rectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 40, 0);
}

@end
