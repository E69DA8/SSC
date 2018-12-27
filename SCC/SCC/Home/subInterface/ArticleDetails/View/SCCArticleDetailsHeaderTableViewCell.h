//
//  SCCArticleDetailsHeaderTableViewCell.h
//  SCC
//
//  Created by E69DA8 on 2018/10/29.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCCHomeViewModel;
@interface SCCArticleDetailsHeaderTableViewCell : UITableViewCell
@property(nonatomic,copy) SCCHomeViewModel *model;
@property(nonatomic,copy) void (^followButtonBlock)(void);
@property(nonatomic,copy) NSString *iconPath;
@property(nonatomic,assign) BOOL isFollow;//是否关注
@end
