//
//  SCCVBaseNavigationController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/23.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCBaseNavigationController.h"

@interface SCCBaseNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation SCCBaseNavigationController




- (void)viewDidLoad{
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    
    [self.navigationBar setTitleTextAttributes:attrs];
    self.navigationBar.translucent = NO;
    
    
    //    /* UINavigationControllerDelegate */
    //    self.delegate = self;
    //
    //
    //    __weak typeof (self)weakSelf = self;
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        //        self.interactivePopGestureRecognizer.enabled = YES;
    //        /* UIGestureRecognizerDelegate */
    //        self.interactivePopGestureRecognizer.delegate = weakSelf;
    //    }
    //    __weak JYHLBaseNavigationController *weakSelf = self;
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.interactivePopGestureRecognizer.delegate = weakSelf;
    //        self.delegate = weakSelf;
    //    }
    //
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.interactivePopGestureRecognizer.enabled = NO;
    //    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
    //
    //        self.interactivePopGestureRecognizer.enabled = NO;
    //    }
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"返回";
    viewController.navigationItem.backBarButtonItem = barButtonItem;
    
    if(self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        
        
    }
    
    
    //    self.interactivePopGestureRecognizer.delegate = nil;
    [super pushViewController:viewController animated:animated];
    
    
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
    
}

@end
