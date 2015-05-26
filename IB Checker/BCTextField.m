//
//  BCTextField.m
//  IB Checker
//
//  Created by Thanh on 5/19/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BCTextField.h"

@implementation BCTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [self rectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self rectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return [self rectForBounds:bounds];
}

//here 40 - is your x offset
- (CGRect)rectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

@end
