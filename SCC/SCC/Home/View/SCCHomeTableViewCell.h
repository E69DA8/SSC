//
//  SCCHomeTableViewCell.h
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCCHomeViewModel;
@interface SCCHomeTableViewCell : UITableViewCell
@property(weak,nonatomic)UIView *bgView;
@property(weak,nonatomic)UIImageView *userIconImageView;//用户头像
@property(nonatomic,strong) void (^homeCellButtonClickBlock)(NSInteger type);//关注1,进入作者主页回调2
@property(nonatomic,copy) SCCHomeViewModel *model;//model
@property(nonatomic,copy) NSString *iconPath;
@property(nonatomic,assign) NSInteger type;//1:隐藏关注按钮 ， 0:显示关注按钮
@end
