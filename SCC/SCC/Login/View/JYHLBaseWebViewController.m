//
//  JYHLBaseWebViewController.m
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/10/23.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "JYHLBaseWebViewController.h"
#import "SSKeychain.h"
@interface JYHLBaseWebViewController ()

@end

@implementation JYHLBaseWebViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setCookie];
    
    [self setupUI];
    
    //边缘添加返回事件
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePanView:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePan];

    
    
}

#pragma mark screenEdgePan 屏幕边界平移事件
-(void)screenEdgePanView:(UIScreenEdgePanGestureRecognizer *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



//- (void)setCookie{
////    [self deleteCookie];
//
//    NSString *token =[NSString stringWithFormat:@"%@",[SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveTokenKey] ? [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:JYHLSaveTokenKey]:@""];
////    if(self.urlStr){
////
////        NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
////                                    [NSDictionary dictionaryWithObject:
////                                     [[NSString alloc] initWithFormat:@"jy-token=%@;",token]
////                                                                forKey:@"Set-Cookie"]
////                                                                          forURL:[NSURL URLWithString:self.urlStr]];
////
////        [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookies:headeringCookie forURL:[NSURL URLWithString:self.urlStr] mainDocumentURL:nil];
////    }
//
//    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"jy-token" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:token forKey:NSHTTPCookieValue];
//    [cookieProperties setObject:[JYHLConfig shareConfig].cookieDomain forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
//
//    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
//
//
//}


- (void)setupUI {
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    如果不想影响其他页面的导航透明度，viewWillDisappear将其设置为nil即可:
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

    
}
- (void)deleteCookie{
    if(self.urlStr == nil){
        return;
    }
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookieAry = [cookieJar cookiesForURL: [NSURL URLWithString: self.urlStr]];
    
    for (cookie in cookieAry) {
        
        [cookieJar deleteCookie: cookie];
        
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
