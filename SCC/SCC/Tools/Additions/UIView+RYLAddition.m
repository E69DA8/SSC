//
//  UIView+CZAddition.m
//  003-小画板
//
//  Created by 刘凡 on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "UIView+RYLAddition.h"

@implementation UIView (RYLAddition)

- (UIImage *)r_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

/// 设置背景图层
- (void)r_backgroundGradientWithColors:(NSArray<UIColor *> *)colors{
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    
    layer.bounds = self.bounds;
    layer.position = self.center;
    
    
//    CGColorRef color1 = [UIColor r_colorWithHex:0xd1b16c].CGColor;
//    CGColorRef color2 = [UIColor r_colorWithHex:0x480000].CGColor;
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:colors.count];
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGColorRef colorRef = obj.CGColor;
        [arrM addObject:(__bridge UIColor *)(colorRef)];
    }];
    layer.colors = arrM.copy;
    
//    layer.colors = @[(__bridge UIColor *)color1, (__bridge UIColor *)color2];
    
    
    layer.locations = @[@0, @1];
    
    
    [self.layer insertSublayer:layer atIndex:0];
//    [self.layer addSublayer:layer];
}


@end
