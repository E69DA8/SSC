//
//  SCCMainTabBarViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/23.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCMainTabBarViewController.h"
#import "KLTNavigationController.h"
#import "SCCBaseNavigationController.h"
#import "SCCLoginViewController.h"

@interface SCCMainTabBarViewController ()

@end

@implementation SCCMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.delegate = self;
    // Do any additional setup after loading the view.
    [self childVCWithClassName:@"SCCHomeViewController" title:@"首页" imageName:@"btn_tabbar_home"];
    [self childVCWithClassName:@"SCCFollowViewController" title:@"关注" imageName:@"btn_tabbar_follow"];
    [self childVCWithClassName:@"SCCMainViewController" title:@"我的" imageName:@"btn_tabbar_my"];
}

- (void)childVCWithClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName{
    
    
    Class cls = NSClassFromString(className);
    
    UIViewController *vc = [[cls alloc]init];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    self.tabBar.tintColor = SCCColor(0x333333);
    
    [UITabBar appearance].translucent = NO;
    
    self.tabBar.clipsToBounds = YES;
    
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    KLTNavigationController *nav = [[KLTNavigationController alloc]initWithRootViewController:vc];
    
    
    [self addChildViewController:nav];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
