//
//  UIViewController+JYHLUMShare.h
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/7/28.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class JYHLShareModel;
@interface UIViewController (JYHLUMShare)

/// 主方法
//- (void)shareWithModel:(JYHLShareModel *)model callBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

- (void)shareWithUrl:(NSString *)url callBack:(void (^)(NSDictionary *dict, NSError *error))callBack;


///// 分享链接
//- (void)shareUrlWithModel:(JYHLShareModel *)model callBack:(void (^)(id response, NSError *error))callBack;
//
//// 分享图片
//- (void)shareImgWithModel:(JYHLShareModel *)model callBack:(void (^)(id response, NSError *error))callBack;

@end
