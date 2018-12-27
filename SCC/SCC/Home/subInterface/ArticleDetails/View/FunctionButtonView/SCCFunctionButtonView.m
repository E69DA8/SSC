//
//  SCCFunctionButtonView.m
//  SCC
//
//  Created by E69DA8 on 2018/10/27.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCFunctionButtonView.h"
#import "SYFavoriteButton.h"

@interface SCCFunctionButtonView()
@property(weak,nonatomic)SYFavoriteButton *fabulousButton;//赞
@property(weak,nonatomic)UILabel *fabulousLabel;
//@property(weak,nonatomic)UIButton *fabulousButton;
@property(weak,nonatomic)UIView *fabulousBgView;
@property(weak,nonatomic)UIImageView *retransmissionImageView;//转发
@property(weak,nonatomic)UILabel *retransmissionLabel;
@property(weak,nonatomic)UIButton *retransmissionButton;
@property(weak,nonatomic)UIImageView *lookCommentImageView;//看评论
@property(weak,nonatomic)UILabel *lookCommentLabel;
@property(weak,nonatomic)UIButton *lookCommentButton;
@property(weak,nonatomic)UIImageView *sendCommentImageView;//发评论
@property(weak,nonatomic)UILabel *sendCommentLabel;
@property(weak,nonatomic)UIButton *sendCommentButton;

@property(weak,nonatomic)UIView *bgView;


@end

@implementation SCCFunctionButtonView

- (void)setupUI{
    
//    functionView_bg
//
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_tabbar_my_sel"]];
//    /**
//     *   模糊效果的三种风格
//     *
//     *  @param UIBlurEffectStyle
//
//     UIBlurEffectStyleExtraLight,//额外亮度，（高亮风格）
//     UIBlurEffectStyleLight,//亮风格
//     UIBlurEffectStyleDark//暗风格
//     *
//     */
//    //实现模糊效果
//    UIBlurEffect *blurEffrct =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//
//    //毛玻璃视图
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffrct];
//
//    visualEffectView.frame = CGRectMake(0, 0, 350, 100);
//
//    visualEffectView.alpha = 0.9;
//
//    [self addSubview:visualEffectView];
    
//    self.backgroundColor = [UIColor redColor];
    
//    self.bgView.backgroundColor = [UIColor redColor];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
//    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_2"]];
//
//    [self addSubview:imageView];
    
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
//    //iOS 8.0
//    * * 模糊效果的三种风格
//    *
//    *  @param UIBlurEffectStyle
//    *
//    * UIBlurEffectStyleExtraLight,  //高亮
//    * UIBlurEffectStyleLight,       //亮
//    * UIBlurEffectStyleDark         //暗
//    * *
    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];
//    effectView.frame = CGRectMake(imageView.frame.size.width/2,0,
//                                  imageView.frame.size.width/2, imageView.frame.size.height);
    [self addSubview:effectView];
    
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
 
//    imageView.alpha = 0;
    
//    self.backgroundColor = SCCRGBColor(0xeaeaec, 0);
//    self.backgroundColor = [UIColor greenColor];
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
//    [self.fabulousImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(SCCWidth(8));
//        make.centerX.equalTo(self).multipliedBy(0.25);
//        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
//    }];
    
    
    [self.fabulousBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCCWidth(8));
        make.centerX.equalTo(self).multipliedBy(0.25);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];
    
    self.fabulousButton.duration = 1;
    
    [self.fabulousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fabulousBgView);
        make.top.equalTo(self.fabulousBgView.mas_bottom).offset(SCCWidth(2));
    }];

    [self.retransmissionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fabulousBgView);
        make.centerX.equalTo(self).multipliedBy(0.75);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];

    [self.retransmissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.retransmissionImageView);
        make.top.equalTo(self.fabulousLabel);
    }];

    [self.lookCommentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fabulousBgView);
        make.centerX.equalTo(self).multipliedBy(1.25);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];

    [self.lookCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.lookCommentImageView);
        make.top.equalTo(self.fabulousLabel);
    }];

    [self.sendCommentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fabulousBgView);
        make.centerX.equalTo(self).multipliedBy(1.75);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];

    [self.sendCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.sendCommentImageView);
        make.top.equalTo(self.fabulousLabel);
    }];

//    [self.fabulousButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.fabulousButton);
//        make.bottom.equalTo(self.fabulousLabel.mas_bottom);
//    }];

    [self.retransmissionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.retransmissionImageView);
        make.bottom.equalTo(self.retransmissionLabel.mas_bottom);
    }];

    [self.lookCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.lookCommentImageView);
        make.bottom.equalTo(self.lookCommentLabel.mas_bottom);
    }];

    [self.sendCommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.sendCommentImageView);
        make.bottom.equalTo(self.sendCommentLabel.mas_bottom);
    }];
}

-(void)setIsThumbsUp:(BOOL)isThumbsUp{
    _isThumbsUp = isThumbsUp;
    self.fabulousButton.selected = isThumbsUp;
}

-(void)setFabulousStr:(NSString *)fabulousStr{
    _fabulousStr = fabulousStr;
//    self.fabulousImageView.image = [UIImage imageNamed:@"btn_article_detail_like"];
    self.fabulousButton.hidden = NO;
    self.fabulousLabel.text = fabulousStr;
}
-(void)setRetransmissStr:(NSString *)retransmissStr{
    _retransmissStr = retransmissStr;
    self.retransmissionImageView.image = [UIImage imageNamed:@"btn_article_detail_share"];
    self.retransmissionLabel.text = retransmissStr;
}
-(void)setCommentStr:(NSString *)CommentStr{
    _CommentStr = CommentStr;
    self.lookCommentImageView.image = [UIImage imageNamed:@"btn_article_detail_talk"];
    self.lookCommentLabel.text = CommentStr;
    self.sendCommentImageView.image = [UIImage imageNamed:@"btn_article_detail_talk1"];
    self.sendCommentLabel.text = @"发评论";
    
}

-(void)functionButtonClick:(UIButton *)btn{
    
//    self.fabulousImageView.image = [UIImage imageNamed:@"btn_article_detail_sel_like"];
    
//    btn.selected = !btn.selected;
    
    if (self.functionButtonClickBlock) {
        self.functionButtonClickBlock(btn.tag);
    }
}

//- (UIImageView *)fabulousImageView{
//    if(!_fabulousImageView){
//        UIImageView *imageV = [[UIImageView alloc]init];
//        [self addSubview:imageV];
//        _fabulousImageView = imageV;
//    }
//    return _fabulousImageView;
//}
- (UIImageView *)retransmissionImageView{
    if(!_retransmissionImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self addSubview:imageV];
        _retransmissionImageView = imageV;
    }
    return _retransmissionImageView;
}

- (UIImageView *)lookCommentImageView{
    if(!_lookCommentImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self addSubview:imageV];
        _lookCommentImageView = imageV;
    }
    return _lookCommentImageView;
}

- (UIImageView *)sendCommentImageView{
    if(!_sendCommentImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self addSubview:imageV];
        _sendCommentImageView = imageV;
    }
    return _sendCommentImageView;
}

- (UILabel *)fabulousLabel{
    if(!_fabulousLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x333333)];
        lab.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
        [self addSubview:lab];
        _fabulousLabel = lab;
    }
    return _fabulousLabel;
}

- (UILabel *)retransmissionLabel{
    if(!_retransmissionLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x333333)];
        lab.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
        [self addSubview:lab];
        _retransmissionLabel = lab;
    }
    return _retransmissionLabel;
}

- (UILabel *)lookCommentLabel{
    if(!_lookCommentLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x333333)];
        lab.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
        [self addSubview:lab];
        _lookCommentLabel = lab;
    }
    return _lookCommentLabel;
}

- (UILabel *)sendCommentLabel{
    if(!_sendCommentLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:12 color:SCCColor(0x333333)];
        lab.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
        [self addSubview:lab];
        _sendCommentLabel = lab;
    }
    return _sendCommentLabel;
}
- (SYFavoriteButton *)fabulousButton{
    if(!_fabulousButton){
        SYFavoriteButton *btn = [[SYFavoriteButton alloc] initWithFrame:CGRectMake(SCCWidth(-14), SCCWidth(-14), SCCWidth(59), SCCWidth(59))];
        btn.tag = 1;
        btn.image = [UIImage imageNamed:@"btn_article_detail_like"];
        btn.duration = 1;
        btn.defaultColor = SCCColor(0x333333);
        btn.lineColor = [UIColor purpleColor];
        btn.favoredColor = [UIColor redColor];
        btn.circleColor = [UIColor yellowColor];
        btn.userInteractionEnabled = YES;
        btn.hidden = YES;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.fabulousBgView addSubview:btn];
        _fabulousButton = btn;
    }
    return _fabulousButton;
}
- (UIButton *)retransmissionButton{
    if(!_retransmissionButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 2;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _retransmissionButton = btn;
    }
    return _retransmissionButton;
}
- (UIButton *)lookCommentButton{
    if(!_lookCommentButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 3;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _lookCommentButton = btn;
    }
    return _lookCommentButton;
}
- (UIButton *)sendCommentButton{
    if(!_sendCommentButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 4;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _sendCommentButton = btn;
    }
    return _sendCommentButton;
}

- (UIView *)bgView{
    if(!_bgView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = SCCColor(0x777777);
        view.alpha = 0.3;
        [self addSubview:view];
        _bgView = view;
    }
    return _bgView;
}
- (UIView *)fabulousBgView{
    if(!_fabulousBgView){
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor greenColor];
        [self addSubview:view];
        _fabulousBgView = view;
    }
    return _fabulousBgView;
}
@end
