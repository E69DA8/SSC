//
//  SCCSharePresentC.m
//  JYHLLiveRoom
//
//  Created by 任永乐 on 17/1/20.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "SCCSharePresentC.h"
#define Share_Height isIPhoneX ? 207 + 20 : 207
@implementation SCCSharePresentC

- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    
    
    UIView *present = self.presentedView;
//    [present r_backgroundGradientWithColors:@[LightColor, DarkColor]];
    UIView *container = self.containerView;
    
    [container addSubview:present];
    
    [present mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(container);
        make.height.mas_equalTo(Share_Height);
    }];
    
    UIView *grayV = [[UIView alloc]init];
    [container insertSubview:grayV atIndex:0];
    grayV.backgroundColor = [UIColor blackColor];
    grayV.alpha = 0.3;
    
    [grayV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(container);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [grayV addGestureRecognizer:tap];
    
    
}
- (void)tapAction:(UITapGestureRecognizer *)recognizer{
    
    [self.presentedView endEditing:YES];
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

@end
