//
//  SCCShareViewController.h
//  SCC
//
//  Created by E69DA8 on 2018/11/30.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCBaseViewController.h"

@interface SCCShareViewController : SCCBaseViewController

@property(nonatomic,copy) NSString *articleId;//分享id

@property(nonatomic,copy) void (^shareClickBlock)(NSInteger type,NSString *url);

@end
