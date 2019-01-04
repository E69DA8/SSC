//
//  JYHLNetworkTool.h
//  JYHLPlayer
//
//  Created by 任永乐 on 16/11/23.
//  Copyright © 2016年 9yu. All rights reserved.
//  网络请求工具类

#import <AFNetworking/AFNetworking.h>
// 网络请求类型
typedef enum: NSInteger{
    GET,
    POST
}requestType;


@interface SCCNetworkTool : AFHTTPSessionManager{
    
}
//单例全局访问点
+ (instancetype)sharedNetworkTool;


/**
 请求主方法

 */
- (void)requestWithType:(requestType)type urlStr:(NSString *)urlStr parameters:(id)parameters callBack:(void(^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 文章列表
 */
- (void)requestArticleListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;
/*
 * 文章详情
 */
- (void)requestArticleDetailsWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 关注
 */
- (void)requestFollowWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 关注列表
 */
- (void)requestFollowListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 未关注列表
 */
- (void)requestNoFollowListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 点赞
 */
- (void)requestThumbsUpWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 喜欢的文章列表
 */
- (void)requestLikeArticleWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 评论
 */
- (void)requestCommentWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 评论列表
 */
- (void)requestCommentListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 评论点赞
 */
- (void)requestCommentThumbsUpWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 意见反馈
 */
- (void)requestFeedbackWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 作者文章列表
 */
- (void)requestUserArticleListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 分享
 */
- (void)requestShareWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 注册
 */
- (void)requestRegisterWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 登录
 */
- (void)requestLoginWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 是否关注
 */
- (void)requestIsFollownWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 我的资料
 */
- (void)requestMyMaterialWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 意见反馈
 */
- (void)requestSuggestionBackWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;

/*
 * 视频接口
 */
- (void)requestVideoListCallBack:(void (^)(NSDictionary *dict, NSError *error))callBack;
@end
