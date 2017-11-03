//
//  ViewController.m
//  AceDownloader
//
//  Created by AceWei on 2017/10/26.
//  Copyright © 2017年 AceWei. All rights reserved.
//

#import "ViewController.h"
#import "AceDownloader.h"
#import "HybridPreLoading.h"
#import "AceDownloadViewController.h"
#import "NSURLSessionOfflineResumeDownloadFileViewController.h"
#import "DownloadTableViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self addWebView];
    
    [self addDownloadBtn];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [self.view addSubview:btn];
//    
//    btn.frame = CGRectMake(100, 100, 150, 70);
//    [btn setTitle:@"下载" forState:UIControlStateNormal];
//    
//    [btn addTarget:self action:@selector(goDownloadVC) forControlEvents:UIControlEventTouchUpInside];
}


- (void)addDownloadBtn
{
//    [self.navigationController.navigationBar add];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(goDownloadVC)];
    
    self.navigationItem.rightBarButtonItem = btn;
}


- (void)goDownloadVC
{
//    AceDownloadViewController *vc = [[AceDownloadViewController alloc] init];
    
    DownloadTableViewController *vc = [[DownloadTableViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    NSURLSessionOfflineResumeDownloadFileViewController *VC = [[NSURLSessionOfflineResumeDownloadFileViewController alloc] init];
//    
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    VC.downloadURL = pasteboard.string;
//    
//    [self.navigationController pushViewController:VC animated:YES];
}


- (void)addWebView
{
    [NSURLProtocol registerClass:[HybridPreLoading class]];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    
    webView.frame = self.view.bounds;
    
    
//    NSString *webURL = @"http://172.16.26.13:5000";
    NSString *webURL = @"http://m.halihali.tv/v/shituxingzhe2yueyuban/0-30.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [webView loadRequest:request];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
