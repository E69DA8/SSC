//
//  JYHLBaseControl.m
//  JYHLLiveRoom
//
//  Created by 任永乐 on 16/12/12.
//  Copyright © 2016年 9yu. All rights reserved.
//

#import "SCCBaseControl.h"

@implementation SCCBaseControl

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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
