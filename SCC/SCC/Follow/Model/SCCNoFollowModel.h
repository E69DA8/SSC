//
//  SCCNoFollowModel.h
//  SCC
//
//  Created by E69DA8 on 2018/11/15.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "BaseObject.h"

@interface SCCNoFollowModel : BaseObject
@property(nonatomic,copy) NSString *autherId;//id
@property(nonatomic,assign) NSInteger is_follow;//是否关注
@property(nonatomic,copy) NSString *head_portrait_url;//头像
@property(nonatomic,copy) NSString *brief_introduction;//作者介绍
@property(nonatomic,copy) NSString *author_name;//作者名字
@property(nonatomic,assign) NSInteger isThumbsUp;//是否点赞

@end
