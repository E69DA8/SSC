//
//  SCCArticleDetailsHeaderTableViewCell.m
//  SCC
//
//  Created by E69DA8 on 2018/10/29.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCArticleDetailsHeaderTableViewCell.h"
#import "SCCHomeViewModel.h"

@interface SCCArticleDetailsHeaderTableViewCell()
@property(weak,nonatomic)UILabel *timeLabel;//时间
@property(weak,nonatomic)UILabel *titleLabel;//标题
@property(weak,nonatomic)UIImageView *userIconImageView;//用户头像
@property(weak,nonatomic)UILabel *userNameLabel;//用户名字
@property(weak,nonatomic)UILabel *userIntroduceLabel;//用户介绍
@property(weak,nonatomic)UILabel *articleTextLavel;//正文
@property(weak,nonatomic)UIButton *followButton;//关注按钮
@property(weak,nonatomic)UILabel *commentTitleLabel;//评论标题
@end
@implementation SCCArticleDetailsHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(SCCWidth(20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(SCCWidth(2));
        make.left.equalTo(self.contentView.mas_left).offset(SCCWidth(20));
        make.right.equalTo(self.contentView.mas_right).offset(SCCWidth(-48));
    }];
    
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SCCWidth(18));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(36), SCCWidth(36)));
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userIconImageView);
        make.right.equalTo(self.contentView).offset(SCCWidth(-20));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(36), SCCWidth(28)));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIconImageView);
        make.left.equalTo(self.userIconImageView.mas_right).offset(SCCWidth(10));
    }];
    
    [self.userIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userIconImageView.mas_bottom);
        make.left.equalTo(self.userNameLabel);
        make.right.equalTo(self.followButton.mas_left).offset(SCCWidth(-10));
    }];
    
    [self.articleTextLavel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIconImageView);
        make.right.equalTo(self.contentView).offset(SCCWidth(-20));
        make.top.equalTo(self.userIconImageView.mas_bottom).offset(SCCWidth(18));
//        make.bottom.equalTo(self.bgView.mas_bottom).offset(SCCWidth(-15));
    }];
    
    [self.commentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.articleTextLavel.mas_bottom).offset(SCCWidth(20));
        make.left.equalTo(self.timeLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(SCCWidth(-16));
    }];
    
    
    
}

-(void)setModel:(SCCHomeViewModel *)model{
    _model = model;
    
    if (model.article_title.length > 0) {
        NSString *titleStr = model.article_title;
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距设置为30
        [paragraphStyle  setLineSpacing:6];
        
        NSMutableAttributedString  *titleStr1 = [[NSMutableAttributedString alloc] initWithString:titleStr];
        [titleStr1  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [titleStr length])];
        
        // 设置Label要显示的text
        [self.titleLabel  setAttributedText:titleStr1];
    }
    
    self.titleLabel.text = model.article_title;
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.iconPath,model.head_portrait_url]] placeholderImage:[UIImage imageNamed:@"user_2"]];
    //    NSLog(@"%@--------%@",self.iconPath,model.head_portrait_url);
    self.userNameLabel.text = model.author_name;
    self.userIntroduceLabel.text = model.brief_introduction;
    
    if (model.article_content.length > 0) {
        
        
        

        
        NSString *contenStr = [self getZZwithString:[NSString stringWithFormat:@"%@",[model.article_content stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"]]];
        
        
        
        if (contenStr.length > 0) {
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 行间距设置为30
        [paragraphStyle  setLineSpacing:8];
        
        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:contenStr];
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contenStr length])];
        
        // 设置Label要显示的text
        [self.articleTextLavel  setAttributedText:setString];
        
    }
    }

    self.timeLabel.text = model.article_pub_time;
    
    
    
}

-(void)setIsFollow:(BOOL)isFollow{
    _isFollow = isFollow;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
        if (isFollow) {
            [self.followButton setImage:[UIImage imageNamed:@"btn_already_follow"] forState:UIControlStateNormal];
            //        self.followButton.hidden = YES;
        }else{
            [self.followButton setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
            //        self.followButton.hidden = NO;
        }
    }else{
        [self.followButton setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
    }
    
}

-(NSString *)getZZwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

- (void)followButtonClick{
    if (self.followButtonBlock) {
        self.followButtonBlock();
    }
}

#pragma mark - 懒加载
- (UILabel *)timeLabel{
    if(!_timeLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x999999)];
        lab.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:lab];
        _timeLabel = lab;
    }
    return _timeLabel;
}
- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:24 color:SCCColor(0x333333)];
        lab.font = [UIFont boldSystemFontOfSize:24];
        [self.contentView addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}
- (UIImageView *)userIconImageView{
    if(!_userIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius = SCCWidth(18);
        imageV.layer.masksToBounds = YES;
        [self.contentView addSubview:imageV];
        _userIconImageView = imageV;
    }
    return _userIconImageView;
}
- (UILabel *)userNameLabel{
    if(!_userNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:14 color:SCCColor(0x333333)];
        [self.contentView addSubview:lab];
        _userNameLabel = lab;
    }
    return _userNameLabel;
}
- (UILabel *)userIntroduceLabel{
    if(!_userIntroduceLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x999999)];
        [self.contentView addSubview:lab];
        _userIntroduceLabel = lab;
    }
    return _userIntroduceLabel;
}
- (UILabel *)articleTextLavel{
    if(!_articleTextLavel){
        UILabel  *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.contentView addSubview:lab];
        _articleTextLavel = lab;
    }
    return _articleTextLavel;
}
- (UIButton *)followButton{
    if(!_followButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(followButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _followButton = btn;
    }
    return _followButton;
}
- (UILabel *)commentTitleLabel{
    if(!_commentTitleLabel){
        UILabel *lab = [UILabel r_labelWithText:@"评论" fontSize:20 color:SCCColor(0x333333)];
        lab.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:lab];
        _commentTitleLabel = lab;
    }
    return _commentTitleLabel;
}
@end
