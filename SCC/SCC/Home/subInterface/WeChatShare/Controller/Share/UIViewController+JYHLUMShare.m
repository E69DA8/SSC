//
//  UIViewController+JYHLUMShare.m
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/7/28.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "UIViewController+JYHLUMShare.h"
//#import "JYHLNetworkTool.h"
//#import "JYHLShareModel.h"

@implementation UIViewController (JYHLUMShare)

//- (void)shareWithModel:(JYHLShareModel *)model callBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
//    switch ([model.shareType integerValue]) {
//        case 1:
//
//            [self shareUrlWithModel:model callBack:callBack];
//            break;
//        case 2:
//            [self shareImgWithModel:model callBack:callBack];
//
//            break;
//
//        default:
//            break;
//    }
//
//}
//
//
//#pragma mark - 分享
///// 分享链接
//- (void)shareUrlWithModel:(JYHLShareModel *)model callBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
//    //
//
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.subject descr:model.text  thumImage:model.image];
//
//    shareObject.webpageUrl = model.url;
//
//
//    messageObject.shareObject = shareObject;
//
//    [SVProgressHUD show];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
//    [[UMSocialManager defaultManager] shareToPlatform:model.type messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
//        [SVProgressHUD dismiss];
//        if(error){
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                [JYHLSVProgressHUD showWithMsg:@"分享失败"];
//            });
//        }else{
//            if([result isKindOfClass:[UMSocialShareResponse class]]){
//                UMSocialShareResponse *resp = result;
//                NSString *method;
//                switch (model.type) {
//                    case UMSocialPlatformType_Sina:
//                        method = @"微博";
//                        break;
//                    case UMSocialPlatformType_WechatSession:
//                        method = @"微信好友";
//                        break;
//                    case UMSocialPlatformType_WechatTimeLine:
//                        method = @"微信朋友圈";
//                        break;
//                    case UMSocialPlatformType_QQ:
//                        method = @"QQ";
//                        break;
//                    case UMSocialPlatformType_Qzone:
//                        method = @"QQ空间";
//                        break;
//                    default:
//                        break;
//                }
//
//
//                [[JYHLNetworkTool sharedNetworkTool] requestShareSuccessWithModule:model.module moduleId:model.moduleId method:method CallBack:callBack];
//            }
//        }
//    }];
//}
//// 分享图片
//- (void)shareImgWithModel:(JYHLShareModel *)model callBack:(void (^)(NSDictionary *dict, NSError *error))callBack{
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:model.subject descr:nil thumImage:model.image];
//
//    shareObject.shareImage = model.image;
//
//
//    messageObject.shareObject = shareObject;
//
//    [SVProgressHUD show];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
//    [[UMSocialManager defaultManager] shareToPlatform:model.type messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
//        [SVProgressHUD dismiss];
//        if(error){
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                [JYHLSVProgressHUD showWithMsg:@"分享失败"];
//            });
//        }else{
//            if([result isKindOfClass:[UMSocialShareResponse class]]){
//                UMSocialShareResponse *resp = result;
//                NSString *method;
//                switch (model.type) {
//                    case UMSocialPlatformType_Sina:
//                        method = @"微博";
//                        break;
//                    case UMSocialPlatformType_WechatSession:
//                        method = @"微信好友";
//                        break;
//                    case UMSocialPlatformType_WechatTimeLine:
//                        method = @"微信朋友圈";
//                        break;
//                    case UMSocialPlatformType_QQ:
//                        method = @"QQ";
//                        break;
//                    case UMSocialPlatformType_Qzone:
//                        method = @"QQ空间";
//                        break;
//                    default:
//                        break;
//                }
//
//
//                [[JYHLNetworkTool sharedNetworkTool] requestShareSuccessWithModule:model.module moduleId:model.moduleId method:method CallBack:callBack];
//            }
//        }
//    }];
//}

- (void)shareWithUrl:(NSString *)url callBack:(void (^)(NSDictionary *, NSError *))callBack{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"股评家" descr:@"股评家是一款财经社区类产品，我们为您提供优质话题内容，大家可以畅所欲言，互动交流，茶余饭后消遣时间的首选。"  thumImage:[UIImage imageNamed:@"user_2"]];
    
    shareObject.webpageUrl = url;
    
    
    messageObject.shareObject = shareObject;
    
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    UMSocialPlatformType typpe = UMSocialPlatformType_WechatSession;
    
    [[UMSocialManager defaultManager] shareToPlatform:typpe messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        [SVProgressHUD dismiss];
        if(error){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [JYHLSVProgressHUD showWithMsg:@"分享失败"];
            });
        }else{
            [JYHLSVProgressHUD showWithMsg:@"分享成功"];
        }
    }];
}


@end
