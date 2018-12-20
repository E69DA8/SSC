//
//  UIImage+TintColor.h
//  ckd
//
//  Created by JmoVxia on 2016/10/21.
//  Copyright © 2016年 David Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CLTintColor)

- (UIImage *) r_imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) r_imageWithGradientTintColor:(UIColor *)tintColor;


+ (UIImage *)r_drawGradientInRect:(CGSize)size withColors:(NSArray *)colors;

@end
