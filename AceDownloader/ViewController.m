//
//  ViewController.m
//  AceDownloader
//
//  Created by AceWei on 2017/10/26.
//  Copyright © 2017年 AceWei. All rights reserved.
//

#import "ViewController.h"
#import "AceDownloader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self addWebView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:btn];
    
    btn.frame = CGRectMake(100, 100, 150, 70);
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(createDownload) forControlEvents:UIControlEventTouchUpInside];
}


- (void)createDownload
{
    //http://172.16.26.13:5000/[Zeus][Sword Art Online Ordinal Scale [2017][GB][1280X720].mkv
    
    NSString *videoURL = @"";
    
//    videoURL = @"http://172.16.26.13:5000/[Zeus][Sword Art Online Ordinal Scale [2017][GB][1280X720].mkv";
    
    
    videoURL = @"http://172.16.26.13:5000/草原夜色美.MP4";
    
//    videoURL = @"http://ubmcmm.baidustatic.com/media/v1/0f000FMMeiaOP1Ob5dGZW6.png";
    
    AceDownloader *down = [AceDownloader sharedAceDownloader];
    [down createDownloadWithURL:videoURL];
}


- (void)addWebView
{
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    
    webView.frame = self.view.bounds;
    
    NSString *webURL = @"http://172.16.26.13:5000";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
