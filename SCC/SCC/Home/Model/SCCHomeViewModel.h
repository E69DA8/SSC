//
//  SCCHomeViewModel.h
//  SCC
//
//  Created by E69DA8 on 2018/11/13.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "BaseObject.h"

@interface SCCHomeViewModel : BaseObject
@property(nonatomic,copy) NSString *articleId;//文章id
@property(nonatomic,copy) NSString *autherId;//作者id
@property(nonatomic,copy) NSString *article_title;//文章标题
@property(nonatomic,copy) NSString *head_portrait_url;//头像
@property(nonatomic,copy) NSString *brief_introduction;//作者介绍
@property(nonatomic,copy) NSString *author_name;//作者名字
@property(nonatomic,copy) NSString *article_content;//文章内容
@property(nonatomic,copy) NSString *article_pub_time;//发表时间
@property(nonatomic,assign) NSInteger is_follow;//是否关注
@property(nonatomic,copy) NSString *discuss_like_mount;//评论数
@property(nonatomic,copy) NSString *article_like_amount;//点赞数
@property(nonatomic,copy) NSString *forwarding_num;//转发数

@end
