//
//  SCCMainViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCMainViewController.h"
#import "SCCMainTableViewCell.h"
#import "SCCHomeHeaderView.h"
#import "SCCMyCommentViewController.h"
#import "SCCFeedbackViewController.h"
#import "SCCAboutViewController.h"
#import "SCCMainModel.h"
#import "SCCLoginViewController.h"
#import "SCCMyLikeViewController.h"

static NSString *CellID = @"SCCMainTableViewCellID";
@interface SCCMainViewController ()
//@property(weak,nonatomic)UITableView *tableView;//tableView
@property(weak,nonatomic)SCCHomeHeaderView *titleView;
@property(weak,nonatomic)UIView *bgView;
@property(weak,nonatomic)UIImageView *userIconImageVeiw;
@property(weak,nonatomic)UILabel *userNameLabel;
@property(weak,nonatomic)UIButton *loginButton;
/*
 * 功能区
 */
@property(weak,nonatomic)UIView *tableViewBgView;
@property(weak,nonatomic)UIImageView *likeIconImageView;//我的喜欢
@property(weak,nonatomic)UILabel *likeNameLabel;
@property(weak,nonatomic)UIButton *likeButton;
@property(weak,nonatomic)UIImageView *commentIconImageView;//我的评论
@property(weak,nonatomic)UILabel *commentNameLabel;
@property(weak,nonatomic)UIButton *commentButton;
@property(weak,nonatomic)UIImageView *feedbackIconImageView;//意见反馈
@property(weak,nonatomic)UILabel *feedbackNameLabel;
@property(weak,nonatomic)UIButton *feedbackButton;
@property(weak,nonatomic)UIImageView *aboutIconImageView;//意见反馈
@property(weak,nonatomic)UILabel *aboutNameLabel;
@property(weak,nonatomic)UIButton *aboutButton;
@property(weak,nonatomic)UIView *signOutView;//退出登录
@property(weak,nonatomic)UIImageView *signOutIconImageView;//意见反馈
@property(weak,nonatomic)UILabel *signOutNameLabel;
@property(weak,nonatomic)UIButton *signOutButton;
@property(weak,nonatomic)UIImageView *nextImageView1;//箭头
@property(weak,nonatomic)UIImageView *nextImageView2;
@property(weak,nonatomic)UIImageView *nextImageView3;
@property(weak,nonatomic)UIImageView *nextImageView4;
@property(weak,nonatomic)UIImageView *nextImageView5;
@property(weak,nonatomic)UIView *separateView1;//分割线
@property(weak,nonatomic)UIView *separateView2;
@property(weak,nonatomic)UIView *separateView3;
@end

@implementation SCCMainViewController{
    NSArray <SCCMainModel *> *_listModerArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] < 1) {
        self.userIconImageVeiw.image = [UIImage imageNamed:@"logo_portrait_not_login"];
        self.userNameLabel.text = @"未登录";
        self.signOutView.hidden = YES;
    }else{
        //        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID]);
        [self loadData];
        self.signOutView.hidden = NO;
    }
}

-(void)setupUI{
    
    self.view.backgroundColor = SCCBgColor;
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view).offset(SCCWidth(20));
        make.left.equalTo(self.view);
        make.height.offset(SCCWidth(77));
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.left.equalTo(self.view).offset(SCCWidth(20));
        make.right.equalTo(self.view).offset(SCCWidth(-20));
        make.height.offset(SCCWidth(169));
    }];
    
    [self.userIconImageVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(31);
        make.centerX.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(72), SCCWidth(72)));
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIconImageVeiw.mas_bottom).offset(SCCWidth(12));
        make.centerX.equalTo(self.bgView);
    }];
    
    [self.tableViewBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.top.equalTo(self.bgView.mas_bottom).offset(SCCWidth(18));
        make.height.offset(SCCWidth(177));
    }];
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.tableViewBgView);
//    }];
    
    [self.likeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewBgView).offset(SCCWidth(11));
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(50));
    }];
    
    [self.likeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(20));
        make.centerY.equalTo(self.likeNameLabel);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(20), SCCWidth(20)));
    }];
    
    [self.nextImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeNameLabel);
        make.right.equalTo(self.tableViewBgView).offset(SCCWidth(-16));
//        make.size.mas_equalTo(CGSizeMake(SCCWidth(14), SCCWidth(14)));
    }];
    
    [self.separateView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableViewBgView);
        make.bottom.equalTo(self.likeNameLabel.mas_bottom).offset(SCCWidth(11));
        make.height.offset(0.5);
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.tableViewBgView);
        make.bottom.equalTo(self.separateView1);
    }];
    
    [self.commentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewBgView).offset(SCCWidth(56));
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(50));
    }];
    
    [self.commentIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(20));
        make.centerY.equalTo(self.commentNameLabel);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(20), SCCWidth(20)));
    }];
    
    [self.nextImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commentNameLabel);
        make.right.equalTo(self.tableViewBgView).offset(SCCWidth(-16));
//        make.size.mas_equalTo(CGSizeMake(SCCWidth(14), SCCWidth(14)));
    }];
    
    [self.separateView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableViewBgView);
        make.bottom.equalTo(self.commentNameLabel.mas_bottom).offset(SCCWidth(11));
        make.height.offset(0.5);
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableViewBgView);
        make.top.equalTo(self.separateView1);
        make.bottom.equalTo(self.separateView2);
    }];
    
    [self.feedbackNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewBgView).offset(SCCWidth(100));
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(50));
    }];
    
    [self.feedbackIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(20));
        make.centerY.equalTo(self.feedbackNameLabel);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(20), SCCWidth(20)));
    }];
    
    [self.nextImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.feedbackNameLabel);
        make.right.equalTo(self.tableViewBgView).offset(SCCWidth(-16));
//        make.size.mas_equalTo(CGSizeMake(SCCWidth(14), SCCWidth(14)));
    }];
    
    [self.separateView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableViewBgView);
        make.bottom.equalTo(self.feedbackNameLabel.mas_bottom).offset(SCCWidth(11));
        make.height.offset(0.5);
    }];
    
    [self.feedbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableViewBgView);
        make.top.equalTo(self.separateView2);
        make.bottom.equalTo(self.separateView3);
    }];
    
    [self.aboutNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewBgView).offset(SCCWidth(144));
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(50));
    }];

    [self.aboutIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableViewBgView).offset(SCCWidth(20));
        make.centerY.equalTo(self.aboutNameLabel);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(20), SCCWidth(20)));
    }];

    [self.nextImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.aboutNameLabel);
        make.right.equalTo(self.tableViewBgView).offset(SCCWidth(-16));
//        make.size.mas_equalTo(CGSizeMake(SCCWidth(14), SCCWidth(14)));
    }];

    [self.aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableViewBgView);
        make.top.equalTo(self.separateView3);
        make.bottom.equalTo(self.tableViewBgView);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.userIconImageVeiw);
        make.bottom.equalTo(self.userNameLabel.mas_bottom);
    }];
    
    [self.signOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableViewBgView.mas_bottom).offset(SCCWidth(20));
        make.left.equalTo(self.view).offset(SCCWidth(20));
        make.right.equalTo(self.view).offset(SCCWidth(-20));
        make.height.offset(SCCWidth(44));
    }];
    
    [self.signOutIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeIconImageView);
        make.centerY.equalTo(self.signOutView);
        make.size.equalTo(self.likeIconImageView);
    }];
    
    [self.signOutNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeNameLabel);
        make.centerY.equalTo(self.signOutView);
    }];
    
    [self.nextImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nextImageView4.mas_right);
        make.centerY.equalTo(self.signOutView);
        make.size.equalTo(self.nextImageView4);
    }];
    
    [self.signOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.signOutView);
    }];
    
    self.titleView.titleStr = @"我的";
    
    self.likeNameLabel.text = @"我的喜欢";
    self.likeIconImageView.image = [UIImage imageNamed:@"icon_my_like"];
    self.nextImageView1.image = [UIImage imageNamed:@"next_icon"];
    
    self.commentNameLabel.text = @"我的评论";
    self.commentIconImageView.image = [UIImage imageNamed:@"icon_like_talk"];
    self.nextImageView2.image = [UIImage imageNamed:@"next_icon"];
    
    self.feedbackNameLabel.text = @"意见反馈";
    self.feedbackIconImageView.image = [UIImage imageNamed:@"icon_my_feedback"];
    self.nextImageView3.image = [UIImage imageNamed:@"next_icon"];
    
    self.aboutNameLabel.text = @"关于我们";
    self.aboutIconImageView.image = [UIImage imageNamed:@"icon_my_we"];
    self.nextImageView4.image = [UIImage imageNamed:@"next_icon"];
    
    self.signOutNameLabel.text = @"退出登录";
    self.signOutIconImageView.image = [UIImage imageNamed:@"icon_my_quit"];
    self.nextImageView5.image = [UIImage imageNamed:@"next_icon"];
    
    
    
}

-(void)loadData{
//    [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID]
    NSDictionary *param = @{
                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID]
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestMyMaterialWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dictData = dict[@"result"];
            
            _listModerArr = [NSArray yy_modelArrayWithClass:[SCCMainModel class] json:dictData[@"materialList"]];
            
            [self.userIconImageVeiw sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",dictData[@"path"],_listModerArr[0].userHead]] placeholderImage:[UIImage imageNamed:@"user_2"]];
            
            NSLog(@"%@%@",dictData[@"path"],_listModerArr[0].userHead);
            
            self.userNameLabel.text = _listModerArr[0].userName;
            
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
    
    }];
    
}

#pragma mark - 点击事件
- (void)functionButtonClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] < 1) {
                SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
                [self presentViewController:view animated:YES completion:nil];
            }else{
            SCCMyLikeViewController *view = [[SCCMyLikeViewController alloc]init];
            view.title = @"我的喜欢";
                [self.navigationController pushViewController:view animated:YES];
                
            }
        }
            break;
            
        case 2:{
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] < 1) {
                SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
                [self presentViewController:view animated:YES completion:nil];
            }else{
            SCCMyCommentViewController *view = [[SCCMyCommentViewController alloc]init];
            view.title = @"我的评论";
            [self.navigationController pushViewController:view animated:YES];
            }
        }
            break;
            
        case 3:{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] < 1) {
                SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
                [self presentViewController:view animated:YES completion:nil];
            }else{
            SCCFeedbackViewController *view = [[SCCFeedbackViewController alloc]init];
            view.title = @"意见反馈";
            [self.navigationController pushViewController:view animated:YES];
            }
        }
            
            break;
            
        case 4:{
            SCCAboutViewController *view = [[SCCAboutViewController alloc]init];
            view.title = @"关于我们";
            [self.navigationController pushViewController:view animated:YES];
        }
            
            break;
            
        case 5:{
            [[NSUserDefaults standardUserDefaults] setObject:@"-1" forKey:SCCUserID];
            [JYHLSVProgressHUD showWithMsg:@"退出登录"];
            self.userNameLabel.text = @"未登录";
            self.userIconImageVeiw.image = [UIImage imageNamed:@"logo_portrait_not_login"];
            self.signOutView.hidden = YES;
        }
            
            break;
            
        default:
            break;
    }
    
    
}

-(void)loginButtonClick{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] < 1) {
        SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
        [self presentViewController:view animated:YES completion:nil];
    }
    
}

#pragma mark - 懒加载
- (SCCHomeHeaderView *)titleView{
    if(!_titleView){
        SCCHomeHeaderView *view = [[SCCHomeHeaderView alloc]init];
        [self.view addSubview:view];
        _titleView = view;
    }
    return _titleView;
}

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
        [self.view addSubview:view];
        _bgView = view;
        
    }
    return _bgView;
}

- (UIImageView *)userIconImageVeiw{
    if(!_userIconImageVeiw){
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius = SCCWidth(36);
        imageV.layer.masksToBounds = YES;
//        imageV.layer.borderWidth = 0.5;
//        imageV.layer.borderColor = [UIColor blackColor].CGColor;
        [self.bgView addSubview:imageV];
        _userIconImageVeiw = imageV;
    }
    return _userIconImageVeiw;
}
- (UILabel *)userNameLabel{
    if(!_userNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.bgView addSubview:lab];
        _userNameLabel = lab;
    }
    return _userNameLabel;
}

- (UIView *)tableViewBgView{
    if(!_tableViewBgView){
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
        [self.view addSubview:view];
        _tableViewBgView = view;
        
    }
    return _tableViewBgView;
}

/*
 * 功能区
 */
- (UIImageView *)likeIconImageView{
    if(!_likeIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _likeIconImageView = imageV;
    }
    return _likeIconImageView;
}
- (UIImageView *)commentIconImageView{
    if(!_commentIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _commentIconImageView = imageV;
    }
    return _commentIconImageView;
}
- (UIImageView *)feedbackIconImageView{
    if(!_feedbackIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _feedbackIconImageView = imageV;
    }
    return _feedbackIconImageView;
}
- (UIImageView *)aboutIconImageView{
    if(!_aboutIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _aboutIconImageView = imageV;
    }
    return _aboutIconImageView;
}

- (UILabel *)likeNameLabel{
    if(!_likeNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.tableViewBgView addSubview:lab];
        _likeNameLabel = lab;
    }
    return _likeNameLabel;
}

- (UILabel *)commentNameLabel{
    if(!_commentNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.tableViewBgView addSubview:lab];
        _commentNameLabel = lab;
    }
    return _commentNameLabel;
}

- (UILabel *)feedbackNameLabel{
    if(!_feedbackNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.tableViewBgView addSubview:lab];
        _feedbackNameLabel = lab;
    }
    return _feedbackNameLabel;
}

- (UILabel *)aboutNameLabel{
    if(!_aboutNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.tableViewBgView addSubview:lab];
        _aboutNameLabel = lab;
    }
    return _aboutNameLabel;
}

- (UIButton *)likeButton{
    if(!_likeButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableViewBgView addSubview:btn];
        _likeButton = btn;
        
    }
    return _likeButton;
}

- (UIButton *)commentButton{
    if(!_commentButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 2;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableViewBgView addSubview:btn];
        _commentButton = btn;
        
    }
    return _commentButton;
}

- (UIButton *)feedbackButton{
    if(!_feedbackButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 3;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableViewBgView addSubview:btn];
        _feedbackButton = btn;
        
    }
    return _feedbackButton;
}

- (UIButton *)aboutButton{
    if(!_aboutButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 4;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableViewBgView addSubview:btn];
        _aboutButton = btn;
        
    }
    return _aboutButton;
}

- (UIImageView *)nextImageView1{
    if(!_nextImageView1){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _nextImageView1 = imageV;
    }
    return _nextImageView1;
}

- (UIImageView *)nextImageView2{
    if(!_nextImageView2){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _nextImageView2 = imageV;
    }
    return _nextImageView2;
}

- (UIImageView *)nextImageView3{
    if(!_nextImageView3){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _nextImageView3 = imageV;
    }
    return _nextImageView3;
}

- (UIImageView *)nextImageView4{
    if(!_nextImageView4){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.tableViewBgView addSubview:imageV];
        _nextImageView4 = imageV;
    }
    return _nextImageView4;
}

- (UIView *)separateView1{
    if(!_separateView1){
        UIView *view = [[UIView  alloc]init];
        view.backgroundColor = SCCColor(0xf4f4f4);
        [self.tableViewBgView addSubview:view];
        _separateView1 = view;
    }
    return _separateView1;
}

- (UIView *)separateView2{
    if(!_separateView2){
        UIView *view = [[UIView  alloc]init];
        view.backgroundColor = SCCColor(0xf4f4f4);
        [self.tableViewBgView addSubview:view];
        _separateView2 = view;
    }
    return _separateView2;
}

- (UIView *)separateView3{
    if(!_separateView3){
        UIView *view = [[UIView  alloc]init];
        view.backgroundColor = SCCColor(0xf4f4f4);
        [self.tableViewBgView addSubview:view];
        _separateView3 = view;
    }
    return _separateView3;
}

- (UIButton *)loginButton{
    if(!_loginButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _loginButton = btn;
    }
    return _loginButton;
}

- (UIView *)signOutView{
    if(!_signOutView){
        UIView *view = [[UIView alloc]init];
        view.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor;
        view.layer.cornerRadius = 12;
        view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.04].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,8);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 12;
        [self.view addSubview:view];
        _signOutView = view;
    }
    return _signOutView;
}
- (UIImageView *)signOutIconImageView{
    if(!_signOutIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.signOutView addSubview:imageV];
        _signOutIconImageView = imageV;
    }
    return _signOutIconImageView;
}
- (UILabel *)signOutNameLabel{
    if(!_signOutNameLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.signOutView addSubview:lab];
        _signOutNameLabel = lab;
    }
    return _signOutNameLabel;
}
- (UIButton *)signOutButton{
    if(!_signOutButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 5;
        [btn addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.signOutView addSubview:btn];
        _signOutButton = btn;
    }
    return _signOutButton;
}
- (UIImageView *)nextImageView5{
    if(!_nextImageView5){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.signOutView addSubview:imageV];
        _nextImageView5 = imageV;
    }
    return _nextImageView5;
}

@end
