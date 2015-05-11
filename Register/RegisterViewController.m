//
//  RegisterViewController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "Utils.h"


@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtRegisterUser;
@property (weak, nonatomic) IBOutlet UITextField *txtRegiterPhone;
@property (weak, nonatomic) IBOutlet UIWebView *webViewHelp;


@property (nonatomic, strong) UITapGestureRecognizer  *tapRecognizer;


@end

@implementation RegisterViewController

@synthesize txtRegisterUser = _txtRegisterUser;
@synthesize txtRegiterPhone = _txtRegiterPhone;
@synthesize tapRecognizer = _tapRecognizer;
@synthesize webViewHelp = _webViewHelp;


- (void)viewDidLoad {
    [super viewDidLoad];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    // delegate
    [self.view addGestureRecognizer:_tapRecognizer];
    self.txtRegisterUser.delegate = self;
    self.txtRegiterPhone.delegate = self;
    // init  UITextField
    _txtRegisterUser.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _txtRegisterUser.leftViewMode = UITextFieldViewModeAlways;

    _txtRegiterPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _txtRegiterPhone.leftViewMode = UITextFieldViewModeAlways;
    
    [self.webViewHelp setBackgroundColor:[UIColor clearColor]];
    [self.webViewHelp setOpaque:NO];
    
    
    NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:@"" isDirectory:YES];
    NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                         pathForResource:@"RegisterHelp" ofType:@"html"
                                                         inDirectory:@""]
                                               encoding:NSUTF8StringEncoding error:nil];
    [_webViewHelp loadHTMLString:html baseURL:baseURL];
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _txtRegisterUser) {
        [self.txtRegisterUser resignFirstResponder];
        [self.txtRegiterPhone becomeFirstResponder];
    } else if (theTextField == _txtRegiterPhone) {
        [self.txtRegiterPhone resignFirstResponder];
    }
    return NO;
}


-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.txtRegisterUser resignFirstResponder];
    [self.txtRegiterPhone resignFirstResponder];
}

- (IBAction)btnRegisterClick:(id)sender {
    if ((_txtRegisterUser.text==NULL)||([_txtRegisterUser.text isEqualToString:@""])){
        [Utils annoucementWithTitle:nil message:@"Chưa nhập vào tên đăng nhập"];
        [_txtRegisterUser becomeFirstResponder];
        return;
    }
    if ((_txtRegiterPhone.text==NULL)||([_txtRegiterPhone.text isEqualToString:@""])){
        [Utils annoucementWithTitle:nil message:@"Chưa nhập số điện thoại"];
        [_txtRegiterPhone becomeFirstResponder];
        return;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
