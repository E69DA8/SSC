//
//  UIView+CZAddition.h
//  003-小画板
//
//  Created by 刘凡 on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RYLAddition)

/// 返回屏幕截图
- (UIImage *)r_snapshotImage;

- (void)r_backgroundGradientWithColors:(NSArray<UIColor *> *)colors;
@end
