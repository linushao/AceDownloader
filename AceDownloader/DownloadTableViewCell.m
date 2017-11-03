//
//  DownloadTableViewCell.m
//  AceDownloader
//
//  Created by AceWei on 2017/10/27.
//  Copyright © 2017年 AceWei. All rights reserved.
//

#import "DownloadTableViewCell.h"

@implementation DownloadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.backgroundView.backgroundColor = [UIColor yellowColor];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundView.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.backgroundColor = [UIColor redColor];
    
    return [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}

@end
