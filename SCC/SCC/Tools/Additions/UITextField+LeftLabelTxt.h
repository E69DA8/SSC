//
//  UITextField+LeftLabelTxt.h
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/8/7.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LeftLabelTxt)

+ (instancetype)r_txtWithFont:(CGFloat)font bgColor:(UIColor *)bgColor leftLblTxt:(NSString *)txt placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor;

@end
