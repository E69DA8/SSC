//
//  JYHLBaseView.m
//  jyhl
//
//  Created by 任永乐 on 16/11/21.
//  Copyright © 2016年 9yu. All rights reserved.
// 

#import "SCCBaseView.h"

@implementation SCCBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI {}


@end
