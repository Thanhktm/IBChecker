//
//  AuthenViewController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "AuthenViewController.h"
#import "Utils.h"
#import "ActiveService.h"
#import "LoginViewControlelr.h"

@interface AuthenViewController ()


@property (weak, nonatomic) IBOutlet UITextField *txtCodeAuthen;
@property (nonatomic, strong) UITapGestureRecognizer  *tapRecognizer;
@property (nonatomic, strong) ActiveService *activeService;
@end

@implementation AuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    [self.view addGestureRecognizer:_tapRecognizer];
    self.txtCodeAuthen.delegate = self;
    // init  UITextField
    _txtCodeAuthen.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _txtCodeAuthen.leftViewMode = UITextFieldViewModeAlways;
    _activeService = [[ActiveService alloc] initWithDelegate:self authtoken:nil];
    
    
}


#pragma mark - tap gesture handler
-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.txtCodeAuthen resignFirstResponder];
}

#pragma mark UITextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _txtCodeAuthen) {
        [self.txtCodeAuthen resignFirstResponder];
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Sevice Response
-(void)successRequest:(BaseService *)service response:(NSDictionary *)data {
    if ([_activeService parser:data context:nil]) {
        LoginViewControlelr *loginViewController = [[LoginViewControlelr alloc] init];
        loginViewController.key = _key;
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}


- (IBAction)btnAuthentiacte:(id)sender {
    if ((_txtCodeAuthen.text == nil) || ([_txtCodeAuthen.text isEqualToString:@""])){
        [Utils annoucementWithTitle:nil message:@"Chưa nhập mã kích hoạt, hãy nhập mã kích hoạt để tiếp tục"];
        [_txtCodeAuthen resignFirstResponder];
        return;
    }
    
    [_activeService activeWithCode:_txtCodeAuthen.text key:_key];
}
@end
