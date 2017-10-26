//
//  AceDownloader.h
//  AceDownloader
//
//  Created by AceWei on 2017/10/26.
//  Copyright © 2017年 AceWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface AceDownloader : NSObject

singleton_interface(AceDownloader)

- (void)createDownloadWithURL:(NSString *)url;

@end
