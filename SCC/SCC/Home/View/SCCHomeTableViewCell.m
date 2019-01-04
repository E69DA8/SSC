//
//  SCCHomeTableViewCell.m
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCHomeTableViewCell.h"
#import "SCCHomeViewModel.h"

@interface SCCHomeTableViewCell()
@property(weak,nonatomic)UILabel *titleLabel;//标题
@property(weak,nonatomic)UILabel *userNameLabel;//用户名字
@property(weak,nonatomic)UILabel *userIntroduceLabel;//用户介绍
@property(weak,nonatomic)UILabel *articleTextLavel;//正文
@property(weak,nonatomic)UIButton *followButton;//关注按钮
@property(weak,nonatomic)UIButton *authorButton;
//@property(weak,nonatomic)UIView *bgView;

@end

@implementation SCCHomeTableViewCell

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
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-SCCWidth(20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(SCCWidth(18));
        make.left.equalTo(self.bgView.mas_left).offset(SCCWidth(16));
        make.right.equalTo(self.bgView.mas_right).offset(SCCWidth(-16));
        make.height.offset(SCCWidth(24));
    }];

    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SCCWidth(18));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(36), SCCWidth(36)));
    }];

    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userIconImageView);
        make.right.equalTo(self.bgView.mas_right).offset(SCCWidth(-12));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(36), SCCWidth(28)));
    }];

    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIconImageView);
        make.left.equalTo(self.userIconImageView.mas_right).offset(SCCWidth(10));
    }];

    [self.userIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userIconImageView.mas_bottom);
        make.left.equalTo(self.userNameLabel);
        make.right.equalTo(self.followButton.mas_left).offset(SCCWidth(-6));
    }];

    [self.articleTextLavel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIconImageView);
        make.right.equalTo(self.bgView.mas_right).offset(SCCWidth(-16));
        make.top.equalTo(self.userIconImageView.mas_bottom).offset(SCCWidth(13));
        make.bottom.equalTo(self.bgView.mas_bottom).offset(SCCWidth(-15));
//        make.height.offset(SCCWidth(150));
    }];

    [self.authorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.userIconImageView);
    }];
    
//    UIView *view1 = [[UIView alloc]init];
//    view1.backgroundColor = SCCRGBColor(0xf82601, 0.3);
//    [self.contentView addSubview:view1];
//
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.titleLabel);
//        make.left.right.equalTo(self.contentView);
//    }];
//
//    UIView *view2 = [[UIView alloc]init];
//    view2.backgroundColor = SCCRGBColor(0xf82601, 0.3);
//    [self.contentView addSubview:view2];
//
//    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.userIconImageView);
//        make.left.right.equalTo(self.contentView);
//    }];

    
    
}

-(void)setModel:(SCCHomeViewModel *)model{
    _model = model;
    
    self.titleLabel.text = model.article_title;

    if (self.titleLabel.text.length > 13) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView).offset(SCCWidth(18));
            make.left.equalTo(self.bgView.mas_left).offset(SCCWidth(16));
            make.right.equalTo(self.bgView.mas_right).offset(SCCWidth(-16));
            make.height.offset(SCCWidth(48));
        }];
    }
    else{
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView).offset(SCCWidth(18));
            make.left.equalTo(self.bgView.mas_left).offset(SCCWidth(16));
            make.right.equalTo(self.bgView.mas_right).offset(SCCWidth(-16));
            make.height.offset(SCCWidth(24));
        }];
    }
    
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.iconPath,model.head_portrait_url]] placeholderImage:[UIImage imageNamed:@"user_2"]];
//    NSLog(@"%@--------%@",self.iconPath,model.head_portrait_url);
    self.userNameLabel.text = model.author_name;
    self.userIntroduceLabel.text = model.brief_introduction;
//    NSString *contenStr = model.article_content;
    
    NSString *contenStr = [self getZZwithString:model.article_content];
//    NSString *contenStr = @"上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会放寒假；阿萨是开发环境案说法上哈回溯法哈sdf法发顺丰科技按时发货撒环境挥洒的护肤好看撒就会-放寒假；阿萨是开发环境案说法";
    
    if (contenStr.length > 0) {
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距设置为30
        [paragraphStyle  setLineSpacing:4];
        
        
        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:contenStr];
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contenStr length])];
        
        // 设置Label要显示的text
        [self.articleTextLavel  setAttributedText:setString];
        
        
    }
    if (self.type) {
        self.followButton.hidden = YES;
    }else{
//        self.followButton.hidden = NO;
//        NSLog(@"%@-------%zd",[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],model.is_follow);
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
            if (model.is_follow) {
                //        [self.followButton setImage:[UIImage imageNamed:@"btn_already_follow"] forState:UIControlStateNormal];
                self.followButton.hidden = YES;
            }else{
                //        [self.followButton setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
                self.followButton.hidden = NO;
            }
        }else{
            self.followButton.hidden = NO;
        }
    }
    
    
    


}

-(NSString *)getZZwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}


-(void)followButtonClick{
    if (self.homeCellButtonClickBlock) {
        self.homeCellButtonClickBlock(1);
    }
    
}

-(void)enterAuthorInterfaceClick{
    if (self.homeCellButtonClickBlock) {
        self.homeCellButtonClickBlock(2);
    }
}

#pragma mark - 懒加载
- (UIView *)bgView{
    if(!_bgView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
//        view.layer.shadowColor = [UIColor blackColor].CGColor;//阴影的颜色
//        view.layer.shadowOpacity = 0.2f;//阴影的透明度
//        view.layer.shadowRadius = 4.f;//阴影的圆角
//        view.layer.shadowOffset = CGSizeMake(4,4);//阴影偏移量
//        view.layer.cornerRadius = 12; //圆角
//        view.frame = CGRectMake(20,97,335,279.5);
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
- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:20 color:SCCColor(0x333333)];
        lab.font = [UIFont boldSystemFontOfSize:20];
        [self.bgView addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
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
- (UILabel *)articleTextLavel{
    if(!_articleTextLavel){
        UILabel  *lab = [[UILabel alloc]init];
        lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        lab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.alpha = 1;
        lab.numberOfLines = 0;
        [self.bgView addSubview:lab];
        _articleTextLavel = lab;
    }
    return _articleTextLavel;
}
- (UIButton *)followButton{
    if(!_followButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(followButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
        _followButton = btn;
    }
    return _followButton;
}
- (UIButton *)authorButton{
    if(!_authorButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(enterAuthorInterfaceClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
        _authorButton = btn;
    }
    return _authorButton;
}

@end
