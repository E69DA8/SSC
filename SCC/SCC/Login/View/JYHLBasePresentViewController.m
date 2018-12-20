//
//  JYHLBasePresentViewController.m
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/10/27.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "JYHLBasePresentViewController.h"

@interface JYHLBasePresentViewController ()

@end

@implementation JYHLBasePresentViewController{
    BOOL _defaultAllowRotation;
    BOOL _defaultStatusBarStyle;
    BOOL _defaultStatusBarHiden;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
    
}
- (BOOL)prefersStatusBarHidden{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    switch (orientation)
    {
        case UIDeviceOrientationLandscapeLeft: {
            return NO;
        }
            break;
        case UIDeviceOrientationLandscapeRight: {
            return NO;
        }
            break;
        default:
            return NO;
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    _defaultStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    _defaultStatusBarHiden = [[UIApplication sharedApplication] isStatusBarHidden];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
//    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    _defaultAllowRotation = appdelegate.allowRotation;
//    appdelegate.allowRotation=NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    如果不想影响其他页面的导航透明度，viewWillDisappear将其设置为nil即可:
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
//    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    appdelegate.allowRotation=_defaultAllowRotation;
    [[UIApplication sharedApplication] setStatusBarStyle:_defaultStatusBarStyle];
     [[UIApplication sharedApplication] setStatusBarHidden:_defaultStatusBarHiden];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

@end
