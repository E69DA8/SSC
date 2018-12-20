//
//  SCCMainTableViewCell.m
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCMainTableViewCell.h"

@interface SCCMainTableViewCell()
@property(weak,nonatomic)UIImageView *iconImageView;
@property(weak,nonatomic)UILabel *titleNameLabel;//标题
@property(weak,nonatomic)UIImageView *nextImageView;//箭头
@property(weak,nonatomic)UIView *separateView;//分割线
@end

@implementation SCCMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SCCWidth(20));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(16), SCCWidth(16)));
    }];
    
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(SCCWidth(16));
    }];
    
    [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(SCCWidth(-16));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(14), SCCWidth(14)));
    }];
    
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.offset(0.5);
    }];
    
    self.iconImageView.image = [UIImage imageNamed:@"user_2"];
    self.titleNameLabel.text = @"我的喜欢";
    self.nextImageView.image = [UIImage imageNamed:@"user_2"];
    
}

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:imageV];
        _iconImageView = imageV;
    }
    return _iconImageView;
}

- (UILabel *)titleNameLabel{
    if(!_titleNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.contentView addSubview:lab];
        _titleNameLabel = lab;
    }
    return _titleNameLabel;
}

- (UIImageView *)nextImageView{
    if(!_nextImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:imageV];
        _nextImageView = imageV;
    }
    return _nextImageView;
}

- (UIView *)separateView{
    if(!_separateView){
        UIView *view = [[UIView  alloc]init];
        view.backgroundColor = SCCColor(0xf4f4f4);
        [self.contentView addSubview:view];
        _separateView = view;
    }
    return _separateView;
}

@end
