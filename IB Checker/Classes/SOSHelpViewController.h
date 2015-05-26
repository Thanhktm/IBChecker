//
//  SOSHelpViewController.h
//  IB Checker
//
//  Created by kienpt on 5/26/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface SOSHelpViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *lbBankName;
@property (strong, nonatomic) IBOutlet UILabel *lbBankAddress;
@property (strong, nonatomic) IBOutlet UIImageView *imgvAddress;

@property (strong, nonatomic) IBOutlet UIImageView *imgvSOS;

@property (strong, nonatomic) IBOutlet UITextView *tvInfo;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@end
