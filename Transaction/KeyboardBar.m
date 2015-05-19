//
//  KeyboardBar.m
//  IB Checker
//
//  Created by Thanh on 5/18/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "KeyboardBar.h"

@implementation KeyboardBar

- (id)init {
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0,0, CGRectGetWidth(screen), 40);
    self = [self initWithFrame:frame];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectInset(frame, 10, 5)];
        self.textView.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f];
        [self addSubview:self.textView];
    }
    return self;
}

@end