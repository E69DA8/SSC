//
//  NSObject+GetVC.m
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/10/9.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "NSObject+GetVC.h"

@implementation NSObject (GetVC)
- (void)findNavigationControllerWithCompletionCallBack:(void(^)())callBack{
    if(![self getCurrentVC].navigationController){
        __weak typeof(self) weakSelf = self;
        [[self getCurrentVC] dismissViewControllerAnimated:NO completion:^{
            __strong typeof(self) strongSelf = weakSelf;
            if(strongSelf){
                
                [strongSelf findNavigationControllerWithCompletionCallBack:callBack];
            }
        }];
    }else{
        callBack();
    }
}

- (UIViewController *)getCurrentVC

{
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;

    
}

- (UIViewController *)getPopCurrentVC{
        UIViewController *result = nil;
    
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
        if (window.windowLevel != UIWindowLevelNormal)
    
        {
    
            NSArray *windows = [[UIApplication sharedApplication] windows];
    
            for(UIWindow * tmpWin in windows)
    
            {
    
                if (tmpWin.windowLevel == UIWindowLevelNormal)
    
                {
    
                    window = tmpWin;
    
                    break;
    
                }
    
            }
    
        }
    
        UIView *frontView = [[window subviews] objectAtIndex:0];
    
        id nextResponder = [frontView nextResponder];
    
        if ([nextResponder isKindOfClass:[UIViewController class]])
    
            result = nextResponder;
    
        else
    
            result = window.rootViewController;
    
        return result;
}



- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}



@end
