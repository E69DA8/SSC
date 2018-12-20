//
//  SCCFollowTableViewCell.h
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCCNoFollowModel;
@interface SCCFollowTableViewCell : UITableViewCell
@property(nonatomic,copy) SCCNoFollowModel *model;//model
@property(nonatomic,copy) NSString *iconPath;
@property(nonatomic,copy) void (^followButtonClickBlock)(void);
@end
