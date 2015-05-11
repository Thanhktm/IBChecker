//
//  LoginController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/21/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "LoginController.h"
#import "Utils.h"
#import "Language.h"
#import "DataBaseHelper.h"

@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *uiTextUser;

@property (weak, nonatomic) IBOutlet UITextField *uiTextPass;

@property (nonatomic, strong) UITapGestureRecognizer  *tapRecognizer;

@property (weak, nonatomic) IBOutlet UIButton *imageChange;

@property (weak, nonatomic) IBOutlet UIButton *uiTextLogin;



@end

@implementation LoginController

@synthesize uiTextUser = _uiTextUser;
@synthesize uiTextPass = _uiTextPass;
@synthesize tapRecognizer = _tapRecognizer;
@synthesize isCheckButton = _isCheckButton;
@synthesize imageChange = _imageChange;
@synthesize uiTextLogin = _uiTextLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    [self.view addGestureRecognizer:_tapRecognizer];
    self.uiTextUser.delegate = self;
    self.uiTextPass.delegate = self;
    
    _uiTextUser.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 20)];
    _uiTextUser.leftViewMode = UITextFieldViewModeAlways;
    
    _uiTextPass.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 20)];
    _uiTextPass.leftViewMode = UITextFieldViewModeAlways;
    
    [self changeLanguage];
    
    if(!_isCheckButton){
        [_imageChange setImage:[UIImage imageNamed:@"im_la_en.png"] forState:UIControlStateNormal];
    }else{
        [_imageChange setImage:[UIImage imageNamed:@"im_la_vn.png"] forState:UIControlStateNormal];//im_la_en.png
    }
    
    
}

-(void)changeLanguage{
    _uiTextUser.placeholder = [Language get:@"USER_NAME"];
    _uiTextPass.placeholder = [Language get:@"PASS_WORD"];
    [_uiTextLogin setTitle:[Language get:@"BT_LOGIN"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _uiTextUser) {
        [self.uiTextUser resignFirstResponder];
        [self.uiTextPass becomeFirstResponder];
    } else if (theTextField == _uiTextPass) {
        [self.uiTextPass resignFirstResponder];
    }
    return NO;
}


-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.uiTextUser resignFirstResponder];
    [self.uiTextPass resignFirstResponder];
}


- (IBAction)btnCheckLogin:(id)sender {
    if ((_uiTextUser.text==NULL)||([_uiTextUser.text isEqualToString:@""])){
        [Utils annoucementWithTitle:[Language get:@"TITLE_DIALOG_WARNING"] message:@"Hãy nhập vào tên đăng nhập"];
        [_uiTextUser becomeFirstResponder];
        [_uiTextPass resignFirstResponder];
        return;
    }
    if ((_uiTextPass.text==NULL)||([_uiTextPass.text isEqualToString:@""])){
        [Utils annoucementWithTitle:[Language get:@"TITLE_DIALOG_WARNING"] message:@"Hãy nhập vào mật khẩu đăng nhập"];
        [_uiTextUser resignFirstResponder];
        [_uiTextPass becomeFirstResponder];
        return;
    }
}

- (IBAction)btnChangeLanguage:(id)sender {
    if (!_isCheckButton) {
        [_imageChange setImage:[UIImage imageNamed:@"im_la_vn.png"] forState:UIControlStateNormal];//im_la_en.png
        [Language setLanguage:@"en"];
        [self changeLanguage];
        _isCheckButton = YES;
        [DataBaseHelper updateLanguage:0];
    }else if(_isCheckButton){
        [_imageChange setImage:[UIImage imageNamed:@"im_la_en.png"] forState:UIControlStateNormal]; // im_la_vn.png
        [Language setLanguage:@"vi"];
        [self changeLanguage];
        _isCheckButton = NO;
        [DataBaseHelper updateLanguage:1];
    }
}


@end
