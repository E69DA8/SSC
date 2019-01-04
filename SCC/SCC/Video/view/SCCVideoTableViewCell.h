//
//  SCCVideoTableViewCell.h
//  SCC
//
//  Created by E69DA8 on 2019/1/4.
//  Copyright © 2019年 E69DA8. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SCCVideoModel;
@interface SCCVideoTableViewCell : UITableViewCell
@property(nonatomic,copy) SCCVideoModel *model;
@property(nonatomic,copy) NSString *iconPath;
@end

NS_ASSUME_NONNULL_END
