//
//  JYHLBaseViewController.m
//  jyhl
//
//  Created by 任永乐 on 16/11/21.
//  Copyright © 2016年 9yu. All rights reserved.
//

#import "SCCBaseViewController.h"



@interface SCCBaseViewController ()

@end

@implementation SCCBaseViewController
- (void)dealloc{
    NSLog(@"%@ - dealloc",NSStringFromClass([self class]));
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleDefault;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self setupUI];
}

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
