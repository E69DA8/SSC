//
//  SCCFollowTableViewCell.m
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCFollowTableViewCell.h"
#import "SCCNoFollowModel.h"

@interface SCCFollowTableViewCell()
@property(weak,nonatomic)UIImageView *userIconImageView;//用户头像
@property(weak,nonatomic)UILabel *userNameLabel;//用户名字
@property(weak,nonatomic)UILabel *userIntroduceLabel;//用户介绍
@property(weak,nonatomic)UIView *bgView;
@property(weak,nonatomic)UIButton *followButton;//关注



@end

@implementation SCCFollowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    self.contentView.backgroundColor = SCCBgColor;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCCWidth(20));
        make.right.equalTo(self.contentView.mas_right).offset(-SCCWidth(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-SCCWidth(16));
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.right.equalTo(self.bgView.mas_right).offset(SCCWidth(-18));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(36), SCCWidth(28)));
    }];
    
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(SCCWidth(17));
        make.top.equalTo(self.bgView).offset(SCCWidth(13));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(36), SCCWidth(36)));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIconImageView);
        make.left.equalTo(self.userIconImageView.mas_right).offset(SCCWidth(10));
    }];
    
    [self.userIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userIconImageView.mas_bottom);
        make.left.equalTo(self.userNameLabel);
        make.right.equalTo(self.userNameLabel.mas_right);
    }];

    
    
    
}

-(void)followButtonClick{
    
    [self.followButton setImage:[UIImage imageNamed:@"btn_already_follow"] forState:UIControlStateNormal];
    
    if (self.followButtonClickBlock) {
        self.followButtonClickBlock();
    }
}

-(void)setModel:(SCCNoFollowModel *)model{
    _model = model;
//    self.userIconImageView.image = [UIImage imageNamed:@"user_2"];
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.iconPath,model.head_portrait_url]] placeholderImage:[UIImage imageNamed:@"user_2"]];
    self.userNameLabel.text = model.author_name;
    self.userIntroduceLabel.text = model.brief_introduction;
    if (model.is_follow) {
        [self.followButton setImage:[UIImage imageNamed:@"btn_already_follow"] forState:UIControlStateNormal];
    }else{
        [self.followButton setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
    }
    
}

#pragma mark - 懒加载
- (UIView *)bgView{
    if(!_bgView){
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor whiteColor];
//        view.layer.shadowColor = [UIColor blackColor].CGColor;//阴影的颜色
//        view.layer.shadowOpacity = 0.2f;//阴影的透明度
//        view.layer.shadowRadius = 4.f;//阴影的圆角
//        view.layer.shadowOffset = CGSizeMake(4,4);//阴影偏移量
//        view.layer.cornerRadius = 12;
        view.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor;
        view.layer.cornerRadius = 12;
        view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.04].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,8);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 12;
        [self.contentView addSubview:view];
        _bgView = view;
    }
    return _bgView;
}
- (UIImageView *)userIconImageView{
    if(!_userIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius = SCCWidth(18);
        imageV.layer.masksToBounds = YES;
        [self.bgView addSubview:imageV];
        _userIconImageView = imageV;
    }
    return _userIconImageView;
}
- (UILabel *)userNameLabel{
    if(!_userNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:14 color:SCCColor(0x333333)];
        [self.bgView addSubview:lab];
        _userNameLabel = lab;
    }
    return _userNameLabel;
}
- (UILabel *)userIntroduceLabel{
    if(!_userIntroduceLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x999999)];
        [self.bgView addSubview:lab];
        _userIntroduceLabel = lab;
    }
    return _userIntroduceLabel;
}
- (UIButton *)followButton{
    if(!_followButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(followButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
        _followButton = btn;
    }
    return _followButton;
}

@end
