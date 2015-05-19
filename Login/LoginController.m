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
#import "AFNetworking.h"
#import "UserInfo.h"

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
    [self loginServer];
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

-(void)loginServer{
    
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
//    
//    NSDictionary *dictHeader = [self getAuthorizationParameter:clientState];
//    NSMutableString *query = [self makeQuery:dictHeader];
//    [request setValue:[NSString stringWithFormat:@"OAuth %@",query] forHTTPHeaderField:@"Authorization"];
//    [request setValue:@"text/html,application/xml,application/xhtml+xml,text/html;q=0.9" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/xml; charset=UTF-8;" forHTTPHeaderField:@"Content-Type"];
//    
//    DLogInfo(@"OAuth %@ ", query);
//    // Add body request
//    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setTimeoutInterval:10.0];
//    
//    
//    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url];
//    [_request setTimeoutInterval:30.0f];
//    [_request setHTTPMethod:@"POST"];
//    [_request setValue:token forHTTPHeaderField:@"API-User-Token"];
//    [_request setHTTPBody:body];
//    NSData *body = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:&error];
//    [NSURLConnection sendAsynchronousRequest:_request
//                                       queue:_queue
//                           completionHandler:^(NSURLResponse response,NSData data,NSError *error) {}
//    
//
//
//    [UserInfo setToken:@""];
    
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//
//    
//    [manager.requestSerializer setValue:@"auserName" forHTTPHeaderField:@"cn_checker"];
//    [manager.requestSerializer setValue:@"passWord" forHTTPHeaderField:@"96e79218965eb72c92a549dd5a330112"];
//    [manager.requestSerializer setValue:@"lang" forHTTPHeaderField:@"vn"];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    
//
//    
//    [manager POST:@"http://10.0.2.7:9081/IBSServerApp/login" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        
//    }];
    
    
    // @"http://10.0.2.7:9081/IBSServerApp/login"
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://10.0.2.7:9081/IBSServerApp/login"]
//                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Authorization"];
//    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue: @"userName" forHTTPHeaderField:@"cn_checker"];
//    [request setValue: @"passWord" forHTTPHeaderField:@"96e79218965eb72c92a549dd5a330112"];
//    [request setValue: @"lang" forHTTPHeaderField:@"vi"];
//    
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    op.responseSerializer = [AFJSONResponseSerializer serializer];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"JSON responseObject: %@ ",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", [error localizedDescription]);
//        
//    }];
//    [op start];
    
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
