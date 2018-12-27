//
//  SCCMyCommentTableViewCell.m
//  SCC
//
//  Created by E69DA8 on 2018/10/26.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCMyCommentTableViewCell.h"
#import "SCCArticleCommentModel.h"

@interface SCCMyCommentTableViewCell ()
@property (weak,nonatomic)UIImageView *userIconImageView;//用户头像
@property(weak,nonatomic)UILabel *userNameLabel;
@property(weak,nonatomic)UILabel *timeLabel;
@property(weak,nonatomic)UIImageView *fabulousImageView;//赞
@property(weak,nonatomic)UILabel *fabulousLabel;
@property(weak,nonatomic)UILabel *articleTextLabel;//文章正文
@property(weak,nonatomic)UIView *separateView;
@property(weak,nonatomic)UIButton *commentThumbsUpButton;


@end

@implementation SCCMyCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    [self.userIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(SCCWidth(10));
        make.left.equalTo(self.contentView).offset(SCCWidth(20));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(28), SCCWidth(28)));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIconImageView);
        make.left.equalTo(self.userIconImageView.mas_right).offset(SCCWidth(10));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.bottom.equalTo(self.userIconImageView.mas_bottom);
    }];
    
    [self.fabulousImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(SCCWidth(-47));
        make.centerY.equalTo(self.userIconImageView);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(14), SCCWidth(14)));
        
    }];
    
    [self.fabulousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fabulousImageView.mas_right).offset(SCCWidth(4));
        make.centerY.equalTo(self.fabulousImageView);
    }];
    
    [self.articleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.right.equalTo(self.contentView).offset(SCCWidth(-20));
        make.top.equalTo(self.userIconImageView.mas_bottom).offset(SCCWidth(8));
    }];
    
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.articleTextLabel.mas_bottom).offset(17);
        make.left.equalTo(self.contentView).offset(SCCWidth(20));
        make.right.equalTo(self.contentView).offset(SCCWidth(-20));
        make.bottom.equalTo(self.contentView).offset(SCCWidth(-10));
        make.height.offset(0.5);
    }];
    
    [self.commentThumbsUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.fabulousImageView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
}

/*
 * 评论点赞
 */
-(void)commentThumbsUpButtonClick{
    if (self.commentThumbsUpButtonClickBlock) {
        self.commentThumbsUpButtonClickBlock();
    }
}

- (void)setModel:(SCCArticleCommentModel *)model{
    _model = model;
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.commentIconPath,model.userHead]] placeholderImage:[UIImage imageNamed:@"user_2"]];
    
    NSLog(@"%@%@",self.commentIconPath,model.userHead);
    
    self.userNameLabel.text = model.userName;
//    self.userNameLabel.backgroundColor = [UIColor redColor];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.createTime];
    
    if (model.isThumbsUp) {
        self.fabulousImageView.image = [UIImage imageNamed:@"btn_article_detail_sel_discuss"];
    }else{
        self.fabulousImageView.image = [UIImage imageNamed:@"btn_article_detail_discuss"];
    }
    
    self.fabulousLabel.text = model.thumbsUpAmount;
    self.articleTextLabel.text = [model.discuss_content stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"分%@分",model.discuss_content);
//    self.articleTextLabel.backgroundColor = [UIColor greenColor];
    
}

- (UIImageView *)userIconImageView{
    if(!_userIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius = SCCWidth(14);
        imageV.layer.masksToBounds = YES;
        [self.contentView addSubview:imageV];
        _userIconImageView = imageV;
    }
    return _userIconImageView;
}

- (UILabel *)userNameLabel{
    if(!_userNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x333333)];
        [self.contentView addSubview:lab];
        _userNameLabel = lab;
    }
    return _userNameLabel;
}

- (UILabel *)timeLabel{
    if(!_timeLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:10 color:SCCColor(0xa5a5a5)];
        [self.contentView addSubview:lab];
        _timeLabel = lab;
    }
    return _timeLabel;
}

- (UIImageView *)fabulousImageView{
    if(!_fabulousImageView){
        UIImageView *imageV = [[UIImageView  alloc]init];
        [self.contentView addSubview:imageV];
        _fabulousImageView = imageV;
    }
    return _fabulousImageView;
}

- (UILabel *)fabulousLabel{
    if(!_fabulousLabel){
        UILabel *lab = [UILabel  r_labelWithText:nil fontSize:14 color:SCCColor(0x333333)];
        [self.contentView addSubview:lab];
        _fabulousLabel = lab;
    }
    return _fabulousLabel;
}

- (UILabel *)articleTextLabel{
    if(!_articleTextLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:14 color:SCCColor(0x333333)];
        [self.contentView addSubview:lab];
        _articleTextLabel = lab;
    }
    return _articleTextLabel;
}

- (UIView *)separateView{
    if(!_separateView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = SCCColor(0xf4f4f4);
        [self.contentView addSubview:view];
        _separateView = view;
    }
    return _separateView;
}

- (UIButton *)commentThumbsUpButton{
    if(!_commentThumbsUpButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(commentThumbsUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _commentThumbsUpButton = btn;
    }
    return _commentThumbsUpButton;
}

@end
