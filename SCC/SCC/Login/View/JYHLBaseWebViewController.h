//
//  JYHLBaseWebViewController.h
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/10/23.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "JYHLBasePresentViewController.h"

@interface JYHLBaseWebViewController : JYHLBasePresentViewController

@property (nonatomic, copy) NSString *urlStr;

- (void)setupUI;

- (void)setCookie;

@end
