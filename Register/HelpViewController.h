//
//  HelpViewController.h
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/7/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController<UIAlertViewDelegate> {
    BOOL isCheckButton;
}
- (IBAction)btnCheckComfirm:(id)sender;

- (IBAction)btnChooseCancel:(id)sender;

- (IBAction)btnChooseOk:(id)sender;


@end
