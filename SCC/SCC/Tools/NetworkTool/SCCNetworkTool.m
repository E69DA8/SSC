//
//  JYHLNetworkTool.m
//  JYHLPlayer
//
//  Created by 任永乐 on 16/11/23.
//  Copyright © 2016年 9yu. All rights reserved.
//  网络请求工具类

#import "SCCNetworkTool.h"
#import <SVProgressHUD.h>
#import "SSKeychain.h"
#import "AFHTTPSessionManager+JYHLHttpManager.h"

/// 财务记录页数标识
//static NSInteger page = 1;

/// 文章列表标识
static NSMutableDictionary *articleDict;

@implementation SCCNetworkTool
//单例全局访问点
+ (instancetype)sharedNetworkTool{
    static SCCNetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SCCNetworkTool alloc]init];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"text/javascript", nil];
        

//        NSString *ua = [self defaultUserAgentString];
//        NSString *newUa = [NSString stringWithFormat:@"%@, %@",ua,[NSString stringWithFormat:@" %@/%@",Prefix_User_Agent,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
//        [instance.requestSerializer setValue:newUa forHTTPHeaderField:@"User-Agent"];
        
        
//        instance.requestSerializer = [AFHTTPRequestSerializer serializer];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
//        articleDict = [NSMutableDictionary dictionary];
    });
    return instance;
}






//- (void)httpErrorCode:(NSInteger)codeNum urlStr:(NSString *)urlStr{
//
//    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
//    NSString *urlSt = [NSString stringWithFormat:@"%@app/ios-check?device-id=%@",JYZBBaseURLStr,deviceId];
//
//
//    NSString *urlStr2 = [NSString stringWithFormat:@"%@app/user-detail?device-id=%@",JYZBBaseURLStr,deviceId];
//
//
//    if([urlStr isEqualToString:urlSt] || [urlStr isEqualToString:urlStr2]){
//
//        return;
//    }
//
//    if(codeNum == 1001 || codeNum == 1002){
//        /// 未登录
//        if(codeNum == 1002){
//            // token已失效
//            [[NSUserDefaults standardUserDefaults]removeObjectForKey:JYHLSaveUserIDKey];
//
//
//
//            [UMessage setAlias:@"" type:@"user" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//
//            }];
//        }
//
//        [SSKeychain deletePasswordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveTokenKey];
//        [[JYHLLiveRoomUserModel sharedUser] removeMsg];
//        if([NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLViewLoginFaceViewController"]){
//            return;
//        }
//
//        JYHLViewLoginFaceViewController *loginVC = [[JYHLViewLoginFaceViewController alloc]init];
//
//        JYHLBaseNavigationController *nav = [[JYHLBaseNavigationController alloc] initWithRootViewController:loginVC];
//
//        if([NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLGoldEyeViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLAnchorDetailViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLGiftView"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLMammonOpenRedPacketViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLMammonRedPacketViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLGoldBowlPresentViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLLiveRoomPayViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLLiveRoomShareViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayerWebViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLGrabRedBagViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLGiftRedBagViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLBuyCountViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLCustomCountViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLIntegralMallViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLShopAllViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLMyShopViewController"]||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLMyTicketViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLMyTicketDetailViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLBuyTogetherBuyViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLBuyTogetherPlayRoomViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLBuyTogetherPayViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLBuytogetherAlertVC"]
//
//           ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomBuyTicketViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomBuyTogetherViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomBaiYuanBuyViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomMyLotteryView"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomMyBaiYuanBuyView"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomMyBuyTogetherView"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomMyBuyTogetherDetailViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomMyBuyTogetherTicketDetailViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLMyTicketDetailViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLLiveRoomForwardViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayerProfileViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLBuyResultViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLWinDetailViewController"] ||
//           [NSStringFromClass([[self getCurrentVC] class]) isEqualToString:@"JYHLPlayRoomIntroductionMsgViewController"]
//
//
//
//
//
//
//           ){
//
//                    nav.modalPresentationStyle = UIModalPresentationCustom;
//
//            [loginVC setLoginSuccessCallBack:^{// 直播间跳转登录成功
//
//                NSString *token = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveTokenKey];
//
//
//                if([JYHLWebSocketManager shareManager].r_socketStatus == YLSocketStatusConnected || [JYHLWebSocketManager shareManager].r_socketStatus == YLSocketStatusReceived){ // 如果 webSocket 处于连接状态
//
//
//                    //        /// 登录方法
//                    [[JYHLWebSocketManager shareManager]r_sendMessageWithType:YLSocketConnectTypeLogin data:@{
//
//                                                                                                              //@"userId":([[NSUserDefaults standardUserDefaults] objectForKey:JYHLSaveUserIDKey] ? [[NSUserDefaults standardUserDefaults] objectForKey:JYHLSaveUserIDKey] : @""),
//
//                                                                                                              @"token": token,
//                                                                                                              //@"token":@"",
//                                                                                                              @"roomId":@([[SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:@"roomID"] integerValue]),
//                                                                                                              @"enter": @([[[NSUserDefaults standardUserDefaults] objectForKey:JYHLLoginEnterKey] integerValue] ? NO : YES)                                  }];
//                    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:JYHLLoginEnterKey];
//
//
//                }
//
//                //                    [[self getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
//
//            }];
//        }
//        [[self getCurrentVC] presentViewController:nav animated:YES completion:nil];
//
//
//    }else if(codeNum == 1007){
////        [[self getCurrentVC] dismissViewControllerAnimated:NO completion:nil];
//        JYHLBindIDCardViewController *bindIDCardVC = [[JYHLBindIDCardViewController alloc]init];
////        bindIDCardVC.modalPresentationStyle = UIModalPresentationCustom;
////        [[self getCurrentVC].navigationController pushViewController:bindIDCardVC animated:YES];
//        [[self getCurrentVC] presentViewController:bindIDCardVC animated:YES completion:nil];
//
//
//    }else if (codeNum == 1017){
//        // 积分不足
//        __weak typeof(self) weakSelf = self;
//        [self findNavigationControllerWithCompletionCallBack:^{
//            __strong typeof(self)strongSelf = weakSelf;
//            if(strongSelf){
//
//                JYHLRechargeIntegralViewController *rechargeIntegralVC = [[JYHLRechargeIntegralViewController alloc] init];
//                rechargeIntegralVC.title = @"钻石充值";
//                [[strongSelf getCurrentVC].navigationController pushViewController:rechargeIntegralVC animated:YES];
//            }
//        }];
//
//    }
////    else if(codeNum == 1004){
////
////        JYHLLiveRoomPayViewController *liveRoomPayVC = [[JYHLLiveRoomPayViewController alloc]init];
////
////        [[self getCurrentVC] presentViewController:liveRoomPayVC animated:YES completion:nil];
////    }
//}



- (void)requestWithType:(requestType)type urlStr:(NSString *)urlStr parameters:(id)parameters callBack:(void(^)(NSDictionary *dict, NSError *error))callBack{
    
//    [self.requestSerializer setValue:[NSString stringWithFormat:@"%@",[SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveTokenKey] ? [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveTokenKey]:@""] forHTTPHeaderField:@"jy-token"];
//    NSLog(@"%@",[self.requestSerializer valueForHTTPHeaderField:@"jy-token"]);
    
    NSString *method;
    switch (type) {
        case GET:
            method = @"GET";
            break;
            
        case POST:
            method = @"POST";
            break;
        default:
            break;
    }
    if(method.length > 0){
        
    
        //start
        [self jy_httpMethod:method URLString:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            // end
            NSDictionary *dict;
            if([responseObject isKindOfClass:[NSData class]]){
                dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
            } else if(responseObject){
                dict = responseObject;
            }
            
            
            
            if(callBack){
                callBack(dict,nil);
            }
//            [self httpErrorCode:[dict[@"code"] integerValue] urlStr:urlStr];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            //end
            if(callBack){
                callBack(nil,error);
            }
        }];

    }
    
}

/*
 * 首页列表
 */
- (void)requestArticleListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
//    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/queryIndexInfo.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 文章详情
 */
- (void)requestArticleDetailsWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/queryArticleDetail.do",SCCBASEURL];

    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 关注
 */
- (void)requestFollowWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/unAndFollowAuthor.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 关注列表
 */
- (void)requestFollowListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/queryFollowList.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 未关注列表
 */
- (void)requestNoFollowListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/queryUnFollowList.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 点赞
 */
- (void)requestThumbsUpWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/unAndThumbsUpArticle.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 喜欢的文章列表
 */
- (void)requestLikeArticleWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/queryLikeArticleList.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 评论
 */
- (void)requestCommentWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/publishDiscuss.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 评论列表
 */
- (void)requestCommentListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/queryDiscussList.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 评论点赞
 */
- (void)requestCommentThumbsUpWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/discussClikPraise.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 意见反馈
 */
- (void)requestFeedbackWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/suggestionBack.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 作者文章列表
 */
- (void)requestUserArticleListWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/queryAutherArticleList.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 分享
 */
- (void)requestShareWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/shareIndex.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 注册
 */
- (void)requestRegisterWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/register.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 登录
 */
- (void)requestLoginWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/login.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 是否关注
 */
- (void)requestIsFollownWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/countFollow.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 我的资料
 */
- (void)requestMyMaterialWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/myMaterial.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}

/*
 * 意见反馈
 */
- (void)requestSuggestionBackWithParam:(NSDictionary *)param CallBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
    
    //    NSString *deviceId = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveDeviceIdKey];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@yxbApp/suggestionBack.do",SCCBASEURL];
    
    [self requestWithType:POST urlStr:urlStr parameters:param callBack:callBack];
}




@end
