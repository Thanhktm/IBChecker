//
//  HelpViewController.m
//  Checker Mobile
//
//  Created by Puganda_Mac on 4/7/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "HelpViewController.h"
#import "CustomNavigator.h"
#import "Utils.h"

@interface HelpViewController ()

@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtn;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation HelpViewController

@synthesize checkBoxBtn = _checkBoxBtn;
@synthesize webView = _webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    isCheckButton = NO;
    [_checkBoxBtn setImage:[UIImage imageNamed:@"im_uncheck.png"] forState:UIControlStateNormal];
    //[self customNavigationBar];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:@"" isDirectory:YES];
    NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                         pathForResource:@"RegisterHelp" ofType:@"html"
                                                         inDirectory:@""]
                                               encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:html baseURL:baseURL];

    // Ket noi mang internet 
//    if([Utils checkStatusNetWork])
//    {
//        
//    }else{
//        [Utils annoucementWithTitle:nil message:@"Không có kết nối mạng, xin hãy thử lại"];
//    }
    
//    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
//    }
}

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (IBAction)btnCheckComfirm:(id)sender {
    if (!isCheckButton) {
        [_checkBoxBtn setImage:[UIImage imageNamed:@"im_check.png"] forState:UIControlStateNormal];
        isCheckButton = YES;
    }else if(isCheckButton){
        [_checkBoxBtn setImage:[UIImage imageNamed:@"im_uncheck.png"] forState:UIControlStateNormal];
        isCheckButton = NO;
    }
}

- (IBAction)btnChooseCancel:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông báo"
                                                        message:@"Bạn có chắc chắn muốn bỏ qua, nếu bạn bỏ qua, bạn sẽ không thể đăng ký sử dụng được chương trình, và thoát khỏi ứng dụng"
                                                       delegate:self
                                              cancelButtonTitle:@"Đồng ý"
                                              otherButtonTitles:@"Hủy bỏ", nil];
    [alertView show];
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( 0 == buttonIndex ){ //cancel button
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        exit(0);
    } else if ( 1 == buttonIndex ){
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}

- (IBAction)btnChooseOk:(id)sender {
    if(!isCheckButton){
        [Utils annoucementWithTitle:nil message:@"Bạn chấp nhận các điều khoản của ứng dụng trước khi, đăng ký sử dụng"];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
