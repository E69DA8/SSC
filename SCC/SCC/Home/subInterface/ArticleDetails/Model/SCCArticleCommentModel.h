//
//  SCCArticleCommentModel.h
//  SCC
//
//  Created by E69DA8 on 2018/11/18.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "BaseObject.h"

@interface SCCArticleCommentModel : BaseObject
@property(nonatomic,copy) NSString *createTime;//评论发表时间
@property(nonatomic,copy) NSString *article_id;//评论文章id
@property(nonatomic,copy) NSString *discuss_content;//评论内容
@property(nonatomic,copy) NSString *discuss_like;//评论点赞数
@property(nonatomic,copy) NSString *user_id;//用户id
@property(nonatomic,copy) NSString *discuss_id;//评论id
@property(nonatomic,copy) NSString *userName;//用户名称
@property(nonatomic,copy) NSString *userHead;//用户头像
@property(nonatomic,copy) NSString *articleId;//文章id


@end
