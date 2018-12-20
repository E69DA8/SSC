 
//  SCCArticleDetailsViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/27.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCArticleDetailsViewController.h"
#import "SCCMyCommentTableViewCell.h"
#import "SCCArticleDetailsHeaderTableViewCell.h"
#import "SCCFunctionButtonView.h"
#import "SCCHomeViewController.h"
#import "SCCHomeTableViewCell.h"
#import "SCCHomeViewModel.h"
#import "SCCArticleCommentModel.h"
#import "LMJKeyboardShowHiddenNotificationCenter.h"
#import "SCCShareViewController.h"
#import "UIViewController+JYHLUMShare.h"
#import "SCCLoginViewController.h"

static NSString *headerCellID = @"SCCArticleDetailsHeaderTableViewCellID";
static NSString *CellID = @"SCCMyCommentTableViewCellID";
@interface SCCArticleDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,LMJKeyboardShowHiddenNotificationCenterDelegate,UITextFieldDelegate>

@property(weak,nonatomic) UITableView *tableView;//tableView
@property(weak,nonatomic)SCCFunctionButtonView *functionButtonView;
@property(weak,nonatomic)UIButton *closeButton;//关闭按钮

//@property (strong, nonatomic) UIImageView *bgImageView;     // 上个页面截图

@property(weak,nonatomic)UITextField *commentTextField;

@property(weak,nonatomic)UIView *keyBoardView;//键盘view

@property(weak,nonatomic)UIButton *sendButton;//发表评理按钮

@property(weak,nonatomic)UIView *separateView;//分割线


@end

@implementation SCCArticleDetailsViewController{
    CGFloat cellHeight;
    CGFloat startPointX;
    CGFloat startPointY;
    CGFloat scale;
    BOOL isHorizontal;
    NSArray<SCCHomeViewModel *> *_listModelArr;
    NSArray<SCCArticleCommentModel *>* _commentModelArr;
    NSString *_commentIconPath;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置代理
    [LMJKeyboardShowHiddenNotificationCenter defineCenter].delegate = self;
    
    [self.commentTextField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];

    
    [self loadData];
    
//    self.navigationController.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//}
//
//- (void)dealloc {
//    self.navigationController.delegate = nil;
//}


-(void)textField1TextChange:(UITextField *)textField{
    if (textField.text.length > 0) {
        [self.sendButton setTitleColor:SCCColor(0x333333) forState:UIControlStateNormal];
    }else{
        [self.sendButton setTitleColor:SCCColor(0xcccccc) forState:UIControlStateNormal];
    }
}

- (void)setupUI{
    
    [self loadCommentData];
    
    [MobClick event:@"article_details"];
    
    self.view.backgroundColor = SCCBgColor;
    
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    self.tableView.frame = CGRectMake(0,TopStatusHeight, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.functionButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(SCCWidth(-10));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(355), SCCWidth(64)));
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCCWidth(44));
        make.right.equalTo(self.view).offset(SCCWidth(-20));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];
    
    UIView *keyBoardV = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height  , [UIScreen mainScreen].bounds.size.width, 60)];
    
    keyBoardV.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:keyBoardV];
    
    self.keyBoardView = keyBoardV;
    
    
    UIView *separateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height  , [UIScreen mainScreen].bounds.size.width, 0.5)];
    
    separateView.backgroundColor = SCCColor(0xebebeb);
    
    [self.view addSubview:separateView];
    
    self.separateView = separateView;
    
    
    
    self.commentTextField.backgroundColor = SCCColor(0xe4e4e5);
    self.sendButton.backgroundColor = [UIColor whiteColor];
    
//    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.commentTextField);
//        make.left.equalTo(self.commentTextField.mas_right).offset(SCCWidth(20));
//    }];
    
}

-(void)loadData{
//
    NSDictionary *param = @{
                            @"articleId" : self.articleId
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestArticleDetailsWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
//            NSLog(@"%@",dict[@"message"]);
            
            _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"list"]];
            
            self.functionButtonView.fabulousStr = _listModelArr[0].article_like_amount;
            self.functionButtonView.retransmissStr = _listModelArr[0].forwarding_num;
            self.functionButtonView.CommentStr = _listModelArr[0].discuss_like_mount;
            
            [self.tableView reloadData];
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
        
    }];
}

- (void)loadCommentData{
    
    NSDictionary *param = @{
                            @"userId" : @"-1",
                            @"articleId" :self.articleId
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestCommentListWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _commentModelArr = [NSArray yy_modelArrayWithClass:[SCCArticleCommentModel class] json:dictData[@"discussList"]];
            
            _commentIconPath = dictData[@"path"];
            
            [self.tableView reloadData];
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentModelArr.count + 1;
//    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        SCCArticleDetailsHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self)weakSelf = self;
        [cell setFollowButtonBlock:^{
            __strong typeof(self)strongSelf = weakSelf;
            if (strongSelf) {
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
                    NSDictionary *param = @{
                                            @"authorId" : _listModelArr[indexPath.row].autherId,
                                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                                            @"remark": _listModelArr[indexPath.row].is_follow == 1 ? @"0" : @"1"
                                            };
                    
                    [[SCCNetworkTool sharedNetworkTool] requestFollowWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
                        if (error) {
                            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
                            return ;
                        }
                        
                        if ([dict[@"state"] isEqualToString:@"success"]) {
                            
                            //                        NSDictionary *dictData = dict[@"result"];
                            //
                            //                        _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"bannerList"]];
                            //
                            //                        _iconPatn = dictData[@"path"];
                            //
                            //                        [self.tableView reloadData];
                            
//                            [JYHLSVProgressHUD showWithMsg:@"关注成功"];
                            [self loadData];
                            
                        }else{
                            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
                        }
                    }];
                    
                }else{
                    
                    SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
                    [self presentViewController:view animated:YES completion:nil];
                }
                
                
                
                
                
            }
        }];
        cell.iconPath = self.iconPath;
        cell.model = _listModelArr[indexPath.row];
        return cell;
    }else{
        SCCMyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _commentModelArr[indexPath.row - 1];
        cell.commentIconPath = _iconPath;
        __weak typeof(self)weakSelf = self;
        [cell setCommentThumbsUpButtonClickBlock:^{
            __strong typeof(self)strongSelf = weakSelf;
            if (strongSelf) {
                NSDictionary *param = @{
                                        @"discussId" : _commentModelArr[indexPath.row - 1].discuss_id
                                        };
                
                [[SCCNetworkTool sharedNetworkTool] requestCommentThumbsUpWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
                    
                    if (error) {
                        [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
                        return ;
                    }
                    
                    if ([dict[@"state"] isEqualToString:@"success"]) {
                        
                        //                        NSDictionary *dictData = dict[@"result"];
                        //
                        //                        _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"bannerList"]];
                        //
                        //                        _iconPatn = dictData[@"path"];
                        //
                        //                        [self.tableView reloadData];
                        
                        [JYHLSVProgressHUD showWithMsg:@"点赞成功"];
                        [self loadCommentData];
                        
                    }else{
                        [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
                    }
                }];
            }
            
        }];
        
        return cell;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 75.f;
    NSLog(@"%.2f",delta);
    if (delta <= -1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    
//    UILabel *lab = [UILabel r_labelWithText:_hintStr fontSize:11 color:[UIColor r_colorWithHex:0x666666]];
//    //    lab.font = [UIFont boldSystemFontOfSize:11];
//    lab.frame = CGRectMake(18, 0, ScreenWidth - 36, 110);
//    [view addSubview:lab];
    
    return view;
    
    
    
}

-(void)closeButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendButtonClick{
    
    if (self.commentTextField.text.length == 0) {
        return;
    }
    [self.view endEditing:YES];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
    
    NSDictionary *param = @{
                            @"articleId" : _listModelArr[0].articleId,
                            @"discussContent" : _commentTextField.text,
                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID]
                            };
    [[SCCNetworkTool sharedNetworkTool]requestCommentWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            //                        NSDictionary *dictData = dict[@"result"];
            //
            //                        _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"bannerList"]];
            //
            //                        _iconPatn = dictData[@"path"];
            //
            //                        [self.tableView reloadData];
            
            [JYHLSVProgressHUD showWithMsg:@"评论成功"];
            
            [self loadCommentData];
            
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:_commentModelArr.count inSection:0];
            [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
        
    }];
        
    }else{
        SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
        [self presentViewController:view animated:YES completion:nil];
    }
    
}

#pragma mark - LMJKeyboardShowHiddenNotificationCenter Delegate

- (void)showOrHiddenKeyboardWithHeight:(CGFloat)height withDuration:(CGFloat)animationDuration isShow:(BOOL)isShow{
    
    NSLog(@"ViewController 接收到%@通知\n高度值：%f\n时间：%f",isShow ? @"弹出":@"隐藏", height,animationDuration);
    
    if (isShow) {
        [UIView animateWithDuration:animationDuration animations:^{
            [_commentTextField setFrame:CGRectMake(_commentTextField .frame.origin.x, [UIScreen mainScreen].bounds.size.height -48 -height, _commentTextField .frame.size.width, _commentTextField .frame.size.height)];
            
            [_keyBoardView setFrame:CGRectMake(_keyBoardView .frame.origin.x, [UIScreen mainScreen].bounds.size.height -60 -height, _keyBoardView .frame.size.width, _keyBoardView .frame.size.height)];
            
            [_sendButton setFrame:CGRectMake(_sendButton .frame.origin.x, [UIScreen mainScreen].bounds.size.height -48 -height, _sendButton .frame.size.width, _sendButton .frame.size.height)];
            
            [_separateView setFrame:CGRectMake(_separateView .frame.origin.x, [UIScreen mainScreen].bounds.size.height - 60.5 -height, _separateView .frame.size.width, _separateView .frame.size.height)];
        }];
        
        
    }else{
        [UIView animateWithDuration:animationDuration animations:^{
            [_commentTextField setFrame:CGRectMake(_commentTextField .frame.origin.x, [UIScreen mainScreen].bounds.size.height -height, _commentTextField .frame.size.width, _commentTextField .frame.size.height)];
            
            [_keyBoardView setFrame:CGRectMake(_keyBoardView .frame.origin.x, [UIScreen mainScreen].bounds.size.height -height, _keyBoardView .frame.size.width, _keyBoardView .frame.size.height)];
            
            [_sendButton setFrame:CGRectMake(_sendButton .frame.origin.x, [UIScreen mainScreen].bounds.size.height -height, _sendButton .frame.size.width, _sendButton .frame.size.height)];
            
            [_separateView setFrame:CGRectMake(_separateView .frame.origin.x, [UIScreen mainScreen].bounds.size.height -height, _separateView .frame.size.width, _separateView .frame.size.height)];
        }];
        
       
    }
    
    
}

//- (void)onResp:(id)resp{
//
//    if([resp isKindOfClass:[SendMessageToWXResp class]]){
//
//        SendMessageToWXResp *req = (SendMessageToWXResp *)resp;
//
//        if(req.errCode == 0){
//            //分享成功
//        }else{
//            //分享失败
//            //            req.errStr 失败原因
//        }
//    }
//}





#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if(!_tableView){
        //1.创建并添加tableView
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        
        tableView.dataSource = self;
        tableView.delegate = self;
        //tableView会随着所在的viewController一起调整尺寸
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.edgesForExtendedLayout = UIRectEdgeNone;//这个也很重要，不然view会被导航栏遮住的
        //注册cell
        [tableView registerClass:[SCCMyCommentTableViewCell class] forCellReuseIdentifier:CellID];
        
        [tableView registerClass:[SCCArticleDetailsHeaderTableViewCell class] forCellReuseIdentifier:headerCellID];
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = SCCWidth(79);

        
//        tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView = tableView;
        
    }
    return _tableView;
}
- (SCCFunctionButtonView *)functionButtonView{
    if(!_functionButtonView){
        SCCFunctionButtonView *view = [[SCCFunctionButtonView alloc]init];
        
        __weak typeof(self)weakSelf = self;
        [view setFunctionButtonClickBlock:^(NSInteger type) {
            __strong typeof(self)strongSelf = weakSelf;
            if (strongSelf) {
                
                if (type == 1) {
                    //                requestThumbsUpWithParam
                    
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
                    
                    NSDictionary *param = @{
                                            @"articleId" : _listModelArr[0].articleId,
                                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID]
                                            };
                    [[SCCNetworkTool sharedNetworkTool]requestThumbsUpWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
                        
                        if (error) {
                            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
                            return ;
                        }
                        
                        if ([dict[@"state"] isEqualToString:@"success"]) {
                            
                            //                        NSDictionary *dictData = dict[@"result"];
                            //
                            //                        _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"bannerList"]];
                            //
                            //                        _iconPatn = dictData[@"path"];
                            //
                            //                        [self.tableView reloadData];
                            
                            [JYHLSVProgressHUD showWithMsg:@"点赞成功"];
                            
                            [self loadData];
                            
                        }else{
                            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
                        }
                        
                    }];
                        
                    }else{
                        SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
                        [self presentViewController:view animated:YES completion:nil];
                    }
                }else if (type == 2){
                    SCCShareViewController *view = [[SCCShareViewController alloc]init];
                    view.articleId = self.articleId;
                    [self presentViewController:view animated:YES completion:nil];
                    [view setShareClickBlock:^(NSInteger type, NSString *url) {
                        __strong typeof(self)strongSelf = weakSelf;
                        if (strongSelf) {
                            
                            [self dismissViewControllerAnimated:YES completion:nil];
                            
                            WXMediaMessage *message = [WXMediaMessage message];
                            message.title = @"【股评家】";
                            message.description = @"股评家是一款财经社区类产品，我们为您提供优质话题内容，大家可以畅所欲言，互动交流，茶余饭后消遣时间的首选。";
                            [message setThumbImage:[UIImage imageNamed:@"user_2"]];
                            WXWebpageObject *webpageobject = [WXWebpageObject object];
                            webpageobject.webpageUrl = url;
                            message.mediaObject = webpageobject;

                            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
                            req.bText = NO;
                            req.message = message;
                            
                            if (type == 1) {
                                req.scene = WXSceneSession;
                            }else if (type == 2){
                                req.scene = WXSceneTimeline;
                            }
                            
                            [WXApi sendReq:req];
                            

                            
                        }
                    }];
                    
                }else if (type ==3){
                    if (_commentModelArr.count > 0) {
                        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                        [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    }
                    
                }else if (type == 4){
                    self.commentTextField.text = nil;
                    [self.commentTextField becomeFirstResponder];
                }
                

            }
        }];
        
        [self.view addSubview:view];
        _functionButtonView = view;
    }
    return _functionButtonView;
}

- (UIButton *)closeButton{
    if(!_closeButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"btn_close_page"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _closeButton = btn;
    }
    return _closeButton;
}

- (UITextField *)commentTextField{
    if(!_commentTextField){
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(SCCWidth(20), [UIScreen mainScreen].bounds.size.height  , [UIScreen mainScreen].bounds.size.width -SCCWidth(98), 36)];
//        textField.placeholder       = @"写下你的想法。。。。";
//        textField.layer.borderColor = SCCColor(0x777777).CGColor;
//        textField.layer.borderWidth = 0.5;
//        textField.backgroundColor = SCCColor(0xe4e4e5);
        textField.layer.cornerRadius = 5;
        textField.layer.masksToBounds = YES;
//        textField.delegate          = self;

        textField.font = [UIFont systemFontOfSize:16];
        //        field1.background = [UIImage imageNamed:@"textBox"];
//        textField.backgroundColor = [UIColor whiteColor];
        textField.textColor = SCCColor(0x333333);
        
        textField.keyboardType = UIKeyboardTypeDefault;
        //输入框 " × " 号一次性删除内容的
        //        textField.clearButtonMode = UITextFieldViewModeAlways;
        
        textField.placeholder = @"发评论";
        textField.leftViewMode = UITextFieldViewModeAlways;
        UIView *field1View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        //        field1View.frame = CGRectMake(0, 0, 30, 30);
        textField.leftView = field1View;
        //设置UITextField的边框的风格
        //        field1.borderStyle = UITextBorderStyleRoundedRect;
        
        [textField setValue:[UIColor r_colorWithHex:0x8e8e93] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
        [textField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        textField.delegate = self;
        [self.view addSubview:textField];
        
        
        [self.view addSubview:textField];
        _commentTextField = textField;
    }
    return _commentTextField;
}

- (UIButton *)sendButton{
    if(!_sendButton){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCCWidth(318), [UIScreen mainScreen].bounds.size.height  , SCCWidth(40), 36)];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"发送" forState:UIControlStateNormal];
        [btn setTitleColor:SCCColor(0xcccccc) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:19];
        [btn addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _sendButton = btn;
    }
    return _sendButton;
}

@end
