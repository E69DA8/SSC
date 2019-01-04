//
//  SCCVideoModel.h
//  SCC
//
//  Created by E69DA8 on 2019/1/4.
//  Copyright © 2019年 E69DA8. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCCVideoModel : BaseObject

@property(nonatomic,copy) NSString *title;//标题
@property(nonatomic,copy) NSString *cover_url;//图片
@property(nonatomic,copy) NSString *video_url;//视频
@property(nonatomic,copy) NSString *videoId;//ID

@end

NS_ASSUME_NONNULL_END
