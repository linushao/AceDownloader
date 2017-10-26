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
    
    [btn addTarget:self action:@selector(goDownloadVC) forControlEvents:UIControlEventTouchUpInside];
}


- (void)goDownloadVC
{
    AceDownloadViewController *vc = [[AceDownloadViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)createDownload
{
    //http://172.16.26.13:5000/[Zeus][Sword Art Online Ordinal Scale [2017][GB][1280X720].mkv
    
    NSString *videoURL = @"";
    
//    videoURL = @"http://172.16.26.13:5000/[Zeus][Sword Art Online Ordinal Scale [2017][GB][1280X720].mkv";
    
    
//    videoURL = @"http://172.16.26.13:5000/草原夜色美.MP4";
    
    videoURL = @"http://211.162.54.19/vlive.qqvideo.tc.qq.com/Am_czl6DsLb9rjmj-IQj0eMbsvdA2BAr-AVk4uc1__zc/z0024mwu72m.mp4?sdtfrom=v1010&guid=735F9E44D86B618DAFF88F16DA17DDAB&vkey=FF4CB00A0500E7C94E2C4EB7117269D228D4BC1AFC9FC9415AD7E6E0967949BC4C5709EC581AA3C1394C12CD698DB6758C335782D19EBB1629F98FD8771C7CC9885756064C040F4F91408E54B3CB853CB39B4D7BA754B7EB867BE0B10D19076A0D6E5351EC559E4252EE9ADF2DCC417E09F7B4746B82E016";
    
//    videoURL = @"http://ubmcmm.baidustatic.com/media/v1/0f000FMMeiaOP1Ob5dGZW6.png";
    
    AceDownloader *down = [AceDownloader sharedAceDownloader];
    [down createDownloadWithURL:videoURL];
}


- (void)addWebView
{
    [NSURLProtocol registerClass:[HybridPreLoading class]];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    
    webView.frame = self.view.bounds;
    
//    NSString *webURL = @"http://172.16.26.13:5000";
    NSString *webURL = @"http://m.halihali.tv/v/shituxingzhe2yueyuban/0-1.html";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
