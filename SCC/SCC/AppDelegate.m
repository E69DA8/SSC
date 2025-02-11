//
//  AppDelegate.m
//  SCC
//
//  Created by E69DA8 on 2018/10/23.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "AppDelegate.h"
#import "SCCMainTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    SCCMainTabBarViewController *mainVC = [[SCCMainTabBarViewController alloc] init];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    
    [self registUMMob];
    
    //微信分享
    [WXApi registerApp:SCCWeChat enableMTA:false];
    
    return YES;
}

#pragma mark - 友盟
- (void)registUMMob{
    [UMConfigure setEncryptEnabled:YES];//打开加密传输
    [UMConfigure setLogEnabled:NO];//设置打开日志
    [UMConfigure initWithAppkey:UMengSDK_AppId channel:nil];
    //    *config = [UMAnalyticsConfig sharedInstance];
    //    config.appKey = UMengSDK_AppId;
    //    config.channelId = @"App Store";
    //    config.ePolicy = REALTIME;
    //
    //    [MobClick startWithConfigure:config];
    //
    ////    [MobClick startSession:nil];
    //
    //    [MobClick setLogEnabled:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
