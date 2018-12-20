//
//  UITextField+LeftLabelTxt.m
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/8/7.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "UITextField+LeftLabelTxt.h"

@implementation UITextField (LeftLabelTxt)

+ (instancetype)r_txtWithFont:(CGFloat)font bgColor:(UIColor *)bgColor leftLblTxt:(NSString *)txt placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor{
    UITextField *field1 = [[UITextField alloc]init];
    field1.font = [UIFont systemFontOfSize:font];
    //        field1.background = [UIImage imageNamed:@"textBox"];
    field1.backgroundColor = bgColor;
    //设置UITextField的左边view出现模式
    if(txt != nil){
        field1.leftViewMode = UITextFieldViewModeAlways;
        UILabel *field1View = [UILabel r_labelWithText:txt fontSize:font color:[UIColor blackColor]];
        field1View.frame = CGRectMake(0, 0, 75, 30);
        field1View.textAlignment = NSTextAlignmentLeft;
        field1.leftView = field1View;
        field1.clearButtonMode = UITextFieldViewModeAlways;
    }
    //        field1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    //输入框 " × " 号一次性删除内容的
    
    field1.placeholder = placeHolder;
    //设置UITextField的边框的风格
    field1.borderStyle = UITextBorderStyleNone;
    [field1 setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
    [field1 setValue:[UIFont systemFontOfSize:font] forKeyPath:@"_placeholderLabel.font"];
    return field1;
}


@end
