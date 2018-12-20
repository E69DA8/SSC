//
//  SCCHomeHeaderView.m
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCHomeHeaderView.h"

@interface SCCHomeHeaderView()

@property(weak,nonatomic)UILabel *titleLabel;//标题

@end

@implementation SCCHomeHeaderView

- (void)setupUI{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCCWidth(20));
        make.top.equalTo(self).offset(SCCWidth(24));
    }];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:32 color:SCCColor(0x333333)];
        lab.font = [UIFont boldSystemFontOfSize:32];
        [self addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}

@end
