//
//  SCCAuthorInterfaceHeaderView.h
//  SCC
//
//  Created by E69DA8 on 2018/11/7.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCBaseView.h"
@class SCCHomeViewModel;
@interface SCCAuthorInterfaceHeaderView : SCCBaseView
@property(nonatomic,strong) SCCHomeViewModel *model;
@property(nonatomic,copy) NSString *iconPatn;
@property(nonatomic,copy) void (^followButtonClickBlock)(void);
@property(nonatomic,assign) NSInteger isFollow;
@end
