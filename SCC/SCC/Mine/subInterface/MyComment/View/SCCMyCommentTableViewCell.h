//
//  SCCMyCommentTableViewCell.h
//  SCC
//
//  Created by E69DA8 on 2018/10/26.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCCArticleCommentModel;
@interface SCCMyCommentTableViewCell : UITableViewCell
@property(nonatomic,copy) SCCArticleCommentModel *model;
@property(nonatomic,copy) NSString *commentIconPath;
@property(nonatomic,copy) void (^commentThumbsUpButtonClickBlock)(void);
@end
