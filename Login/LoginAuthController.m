//
//  LoginAuthController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/21/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "LoginAuthController.h"
#import "LoginController.h"
#import "Utils.h"
#import "Language.h"
#import "DataBaseHelper.h"

@interface LoginAuthController ()

@property (weak, nonatomic) IBOutlet UILabel *txtUserName;

@property (weak, nonatomic) IBOutlet UITextField *txtPassWord;

@property (weak, nonatomic) IBOutlet UIButton *lableLogin;

@property (weak, nonatomic) IBOutlet UIButton *imageLanguage;

@property (weak, nonatomic) IBOutlet UIButton *lableSwitchUser;


@property (weak, nonatomic) IBOutlet UILabel *lableWellcom;


@property (nonatomic, strong) UITapGestureRecognizer  *tapRecognizer;


@end

@implementation LoginAuthController
@synthesize txtUserName = _txtUserName;
@synthesize txtPassWord = _txtPassWord;
@synthesize lableLogin = _lableLogin;
@synthesize imageLanguage = _imageLanguage;
@synthesize lableSwitchUser = _lableSwitchUser;
@synthesize lableWellcom = _lableWellcom;
@synthesize isCheckButton = _isCheckButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!_isCheckButton){
        [_imageLanguage setImage:[UIImage imageNamed:@"im_la_en.png"] forState:UIControlStateNormal];
    }else{
        [_imageLanguage setImage:[UIImage imageNamed:@"im_la_vn.png"] forState:UIControlStateNormal];//im_la_en.png
    }
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    [self.view addGestureRecognizer:_tapRecognizer];
     self.txtPassWord.delegate = self;
    _txtPassWord.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 20)];
    _txtPassWord.leftViewMode = UITextFieldViewModeAlways;
    [self changeLanguage];
}

-(void)changeLanguage{
    [_lableLogin setTitle:[Language get:@"BT_LOGIN"] forState:UIControlStateNormal];
    [_lableSwitchUser setTitle:[Language get:@"BT_SWITCH_USER"] forState:UIControlStateNormal];
    _lableWellcom.text = [Language get:@"TITLE_LOGIN"];
    _txtPassWord.placeholder = [Language get:@"PASS_WORD"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _txtPassWord) {
        [self.txtPassWord resignFirstResponder];
    }
    return NO;
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.txtPassWord resignFirstResponder];
}


- (IBAction)btnChangeLanguage:(id)sender {
    if (!_isCheckButton) {
        [_imageLanguage setImage:[UIImage imageNamed:@"im_la_vn.png"] forState:UIControlStateNormal];//im_la_en.png
        [Language setLanguage:@"en"];
        [self changeLanguage];
        _isCheckButton = YES;
        [DataBaseHelper updateLanguage:0];
    }else if(_isCheckButton){
        [_imageLanguage setImage:[UIImage imageNamed:@"im_la_en.png"] forState:UIControlStateNormal]; // im_la_vn.png
        [Language setLanguage:@"vi"];
        [self changeLanguage];
        _isCheckButton = NO;
        [DataBaseHelper updateLanguage:1];
    }
}

- (IBAction)btnChangeUser:(id)sender {
    LoginController *controller=[[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    controller.isCheckButton = _isCheckButton;
    [Utils switchScreen:controller mainView:self.view];
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)btnLogin:(id)sender {
    if ((_txtPassWord.text==NULL)||([_txtPassWord.text isEqualToString:@""])){
        [Utils annoucementWithTitle:[Language get:@"TITLE_DIALOG_WARNING"] message:@"Hãy nhập vào mật khẩu đăng nhập"];
        [_txtPassWord resignFirstResponder];
        return;
    }
}



@end
