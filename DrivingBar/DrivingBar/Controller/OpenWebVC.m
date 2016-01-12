//
//  AboutVC.m
//  EAPController
//
//  Created by admin on 15/10/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//
#import "public.h"
#import "OpenWebVC.h"
@interface OpenWebVC ()<UIWebViewDelegate>{
    UIWebView *webView;
    UILabel *titleLabel;
}
@end

@implementation OpenWebVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self initView];
}

- (void)setup {
    
}

- (void)initView {
    //set navigationbar title
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2 - self.title.length/2, 0, self.title.length, 44)];
    //titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.textColor=[UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;

    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
}

-(void)LoadWithTitle:(NSString *)title Url:(NSString *)url{
    titleLabel.text = title;
    [self loadWebPageWithString:url];
}

-(void)loadWebPageWithString:(NSString*)urlString{
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end
