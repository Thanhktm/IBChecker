//
//  CustomNavigator.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/7/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigator : UIView

@property (nonatomic, copy) UIImageView *imgView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *stateLabel;

@end
