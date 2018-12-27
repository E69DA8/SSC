//
//  SCCArticleDetailsViewController.h
//  SCC
//
//  Created by E69DA8 on 2018/10/27.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCBaseViewController.h"

@interface SCCArticleDetailsViewController : SCCBaseViewController
@property (strong, nonatomic) UIImage *bgImage;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@property(nonatomic,copy) NSString *articleId;
@property(nonatomic,copy) NSString *iconPath;
@property(nonatomic,assign) BOOL isThumbsUp;//是否点赞
@property(nonatomic,assign) BOOL isFollow;//是否关注
@end
