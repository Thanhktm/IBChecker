//
//  BCTableView.m
//  IB Checker
//
//  Created by Thanh on 5/18/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BCTableView.h"
#import "KeyboardBar.h"

@interface BCTableView()
// Override inputAccessoryView to readWrite
@property (nonatomic, readwrite, retain) IBOutlet UIView *inputAccessoryView;

@end
@implementation BCTableView

// Override canBecomeFirstResponder
// to allow this view to be a responder
- (bool) canBecomeFirstResponder {
    return true;
}

//// Override inputAccessoryView to use
//// an instance of KeyboardBar
//- (UIView *)inputAccessoryView {
//    if(!_inputAccessoryView) {
//        _inputAccessoryView = [[KeyboardBar alloc] init];
//    }
//    return _inputAccessoryView;
//}


@end
