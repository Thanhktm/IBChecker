//
//  AuthenViewController.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AuthenViewController : BaseViewController<UITextFieldDelegate>
@property(strong, nonatomic) NSString *key;
- (IBAction)btnAuthentiacte:(id)sender;
@end
