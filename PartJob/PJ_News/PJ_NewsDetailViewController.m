//
//  PJ_NewsDetailViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/5.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_NewsDetailViewController.h"

#import <WebKit/WebKit.h>

@interface PJ_NewsDetailViewController ()

@end

@implementation PJ_NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:webView];
    
    NSString *urlStr = _object[@"url"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
