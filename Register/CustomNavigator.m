//
//  CustomNavigator.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/7/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "CustomNavigator.h"

@implementation CustomNavigator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        self.backgroundColor = [UIColor grayColor];
//        self.imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_navigation_bar.png"]];
//        [self addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.highlightedTextColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.titleLabel.shadowOffset = CGSizeMake(0, -1);
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:self.titleLabel];
        
        self.stateLabel = [[UILabel alloc] init];
        self.stateLabel.font = [UIFont systemFontOfSize:11];
        self.stateLabel.textColor = [UIColor whiteColor];
        self.stateLabel.highlightedTextColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        self.stateLabel.backgroundColor = [UIColor clearColor];
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.stateLabel.shadowOffset = CGSizeMake(0, -1);
        self.stateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:self.stateLabel];
    }
    
//    [self update];
    return self;
}

#pragma mark -

- (void)update
{
    float margin = (self.stateLabel.text ==nil||[self.stateLabel.text isEqualToString:@""])?7.0f:0.0f;
    CGSize actualTitleSize = [self.titleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:20] forWidth:self.bounds.size.width lineBreakMode:NSLineBreakByTruncatingTail];
    CGRect titleLabelFrame = CGRectMake((self.bounds.size.width - actualTitleSize.width) / 2, margin, actualTitleSize.width, 30);
    self.titleLabel.frame = titleLabelFrame;
    
    
    CGSize actualStatusTitleSize = [self.stateLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:11] forWidth:self.bounds.size.width lineBreakMode:NSLineBreakByTruncatingTail];
    
    self.stateLabel.frame = CGRectMake((self.bounds.size.width - actualStatusTitleSize.width) / 2, 28, actualStatusTitleSize.width, 14);
    
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    [self update];
}

- (NSString *)title
{
    return self.titleLabel.text;
}


@end
