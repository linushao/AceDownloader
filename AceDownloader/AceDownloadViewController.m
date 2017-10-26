//
//  AceDownloadViewController.m
//  AceDownloader
//
//  Created by 魏诗豪 on 2017/10/27.
//  Copyright © 2017年 AceWei. All rights reserved.
//

#import "AceDownloadViewController.h"
#import <Masonry.h>
#import <YYCategories.h>
#import "AceDownloader.h"

@interface AceDownloadViewController ()

@property (nonatomic, strong) UITextField *urlTextField;

@end

@implementation AceDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addUrlTextField];
    [self addDownloadButton];
}


- (void)addUrlTextField
{
    if (!self.urlTextField) {
        self.urlTextField = [[UITextField alloc] init];
    }
    
    [self.view addSubview:self.urlTextField];
    
    self.urlTextField.backgroundColor = [UIColor redColor];
    
    [self.urlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.offset(180);
        make.height.mas_equalTo(30);
    }];
}


- (void)addDownloadButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:btn];
    
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(self.urlTextField.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.urlTextField);
    }];
    
    [btn addBlockForControlEvents:UIControlEventTouchUpInside
                            block:^(id  _Nonnull sender) {
                                NSString *videoURL = self.urlTextField.text;
                                AceDownloader *down = [AceDownloader sharedAceDownloader];
                                [down createDownloadWithURL:videoURL];
                            }];
}


@end
