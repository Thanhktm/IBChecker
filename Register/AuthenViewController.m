//
//  AuthenViewController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/6/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "AuthenViewController.h"
#import "Utils.h"

@interface AuthenViewController ()


@property (weak, nonatomic) IBOutlet UITextField *txtCodeAuthen;
@property (weak, nonatomic) IBOutlet UIWebView *iuWebView;
@property (nonatomic, strong) UITapGestureRecognizer  *tapRecognizer;

@end

@implementation AuthenViewController
@synthesize txtCodeAuthen = _txtCodeAuthen;
@synthesize iuWebView = _iuWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    [self.view addGestureRecognizer:_tapRecognizer];
    self.txtCodeAuthen.delegate = self;
    // init  UITextField
    _txtCodeAuthen.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    _txtCodeAuthen.leftViewMode = UITextFieldViewModeAlways;
    
    [self.iuWebView setBackgroundColor:[UIColor clearColor]];
    [self.iuWebView setOpaque:NO];
    // AuthenHelp.html
    NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:@"" isDirectory:YES];
    NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                         pathForResource:@"AuthenHelp" ofType:@"html"
                                                         inDirectory:@""]
                                               encoding:NSUTF8StringEncoding error:nil];
    [_iuWebView loadHTMLString:html baseURL:baseURL];
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

- (IBAction)btnAuthentiacte:(id)sender {
    if ((_txtCodeAuthen.text==NULL)||([_txtCodeAuthen.text isEqualToString:@""])){
        [Utils annoucementWithTitle:nil message:@"Chưa nhập mã kích hoạt, hãy nhập mã kích hoạt để tiếp tục"];
        [_txtCodeAuthen resignFirstResponder];
        return;
    }
}
@end
