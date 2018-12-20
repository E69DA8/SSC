//
//  SCCFunctionButtonView.h
//  SCC
//
//  Created by E69DA8 on 2018/10/27.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCBaseView.h"

@interface SCCFunctionButtonView : SCCBaseView
@property(nonatomic,copy) void (^functionButtonClickBlock)(NSInteger type);//功能按钮回调
@property(nonatomic,copy) NSString *fabulousStr;//点赞数
@property(nonatomic,copy) NSString *retransmissStr;//转发数
@property(nonatomic,copy) NSString *CommentStr;//评论数
@end
