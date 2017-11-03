//
//  DownloadTableViewController.m
//  AceDownloader
//
//  Created by AceWei on 2017/10/27.
//  Copyright © 2017年 AceWei. All rights reserved.
//

#import "DownloadTableViewController.h"
#import <Masonry.h>

#import "DownloadTableViewCell.h"

@interface DownloadTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DownloadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
}

- (void)addTableView
{
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] init];
    }
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[DownloadTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    _tableView.rowHeight = 61;
    _tableView.tableFooterView = [UIView new];
    
    _tableView.bounces = NO;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
}


#pragma mark - 数据源方法
// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

//返回有多少个Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    static NSString *ideitifier = @"cell";
    
//    DownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    
    static NSString *cellID = @"cell";
    
    
//    DownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    [tableView registerClass:[DownloadTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    DownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
        cell = [[DownloadTableViewCell alloc] init];
    }
    
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = @"aaa";
    
    return cell;
    
    
    
    
    
//    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    cell.textLabel.text=@"aaa";
//    cell.detailTextLabel.text=@"111";
//    return cell;
}

@end
