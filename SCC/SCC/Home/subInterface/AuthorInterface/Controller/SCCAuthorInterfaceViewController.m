//
//  SCCAuthorInterfaceViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/11/7.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCAuthorInterfaceViewController.h"
#import "SCCHomeTableViewCell.h"
#import "SCCAuthorInterfaceHeaderView.h"
#import "SCCHomeViewModel.h"
#import "SCCArticleDetailsViewController.h"
#import "SCCLoginViewController.h"

static NSString *CellID = @"SCCAuthorInterfaceViewControllerCellID";
@interface SCCAuthorInterfaceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic)SCCAuthorInterfaceHeaderView *headerView;//headerView
@property(weak,nonatomic)UITableView *tableView;
@property(weak,nonatomic)UIView *titleView;
@property(weak,nonatomic)UIImageView *titleIconImageView;
@property(weak,nonatomic)UILabel *titleLabel;
@property(weak,nonatomic)UIButton *followButton;
@property(weak,nonatomic)UIButton *backButton;

@end

@implementation SCCAuthorInterfaceViewController{
    NSArray<SCCHomeViewModel *>*_listModelArr;
    NSString *_iconPatn;
    NSInteger _page;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}

-(void)setupUI{
    
    
    
    [self loadData];
    
    self.titleIconImageView.alpha = 0;
    self.titleLabel.alpha = 0;
    self.followButton.alpha = 0;
    
//    [self.tableView addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
    
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //    self.tableView.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.view.backgroundColor = SCCBgColor;
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(TopStatusHeight);
        make.left.right.equalTo(self.view);
        make.height.offset(63);
    }];
    
    [self.titleIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView);
        make.centerX.equalTo(self.titleView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleIconImageView.mas_bottom);
        make.centerX.equalTo(self.titleIconImageView);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView).offset(12);
        make.left.equalTo(self.titleView).offset(16);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton);
        make.right.equalTo(self.titleView).offset(-10);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModelArr.count;
//    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.type = 1;
    cell.iconPath = _iconPatn;
    cell.model = _listModelArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SCCHomeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    SCCArticleDetailsViewController *detail = [[SCCArticleDetailsViewController alloc]init];
    //    detail.selectIndexPath = indexPath;
    //    // 截屏
    //    detail.bgImage = [self imageFromView];
    //    detail.titles = self.titles[indexPath.row];
    //    detail.titleTwo = self.titleTwos[indexPath.row];
    //    detail.content = self.contents[indexPath.row];
    //    detail.imageName = self.dataSource[indexPath.row];
    detail.iconPath = _iconPatn;
    detail.articleId = _listModelArr[indexPath.row].articleId;
    NSLog(@"%@",_listModelArr[0].articleId);
    [self presentViewController:detail animated:YES completion:nil];
}


-(void)follow{
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
            
            NSDictionary *param = @{
                                    @"authorId" : self.autherId,
                                    @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                                    @"remark": @(!self.isFollow)
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
                    
//                    [JYHLSVProgressHUD showWithMsg:@"关注成功"];
                    
                    self.isFollow = !self.isFollow;
                    
                    [self loadData];
                    
                }else{
                    if (!dict[@"message"]) {
                        [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
                    }
                }
            }];
        }else{
            
            SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
            
            [self presentViewController:view animated:YES completion:nil];
        }
    
}


- (void)loadData{
    _page = 1;
    
    NSDictionary *param = @{
                            @"autherId" : self.autherId,
                            @"pageNum" : @"1"
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestUserArticleListWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {

        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"autherArticleList"]];
            
            _iconPatn = dictData[@"path"];
            
            [self.titleIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_iconPatn,_listModelArr[0].head_portrait_url]] placeholderImage:[UIImage imageNamed:@"user_2"]];
            self.titleLabel.text = _listModelArr[0].author_name;
            
            self.headerView.iconPatn = _iconPatn;
            self.headerView.model = _listModelArr[0];
            self.headerView.isFollow = self.isFollow;
            
            if (self.isFollow) {
                [self.followButton setImage:[UIImage imageNamed:@"btn_already_follow"] forState:UIControlStateNormal];
            }else{
                [self.followButton setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
            }
            
            [self.tableView reloadData];
            
        }else{
            if (!dict[@"message"]) {
                [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
            }
        }
        
    }];
}

/**
 *  上拉加载数据
 */
- (void)loadMoreData:(MJRefreshFooter *)footer{
    
    NSDictionary *param = @{
                            @"autherId" : self.autherId,
                            @"pageNum" : [NSString stringWithFormat:@"%zd",_page + 1]
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestUserArticleListWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _page  = _page + 1;
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            [arrM addObjectsFromArray:_listModelArr];
            NSArray *newModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"autherArticleList"]];
            _listModelArr = [arrM arrayByAddingObjectsFromArray:newModelArr];
            
            [self.tableView reloadData];
            [footer endRefreshing];
        }else{
            [footer endRefreshingWithNoMoreData];
        }
        
        
    }];
    
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    CGFloat offset = self.tableView.contentOffset.y;
//    CGFloat delta = offset / 75.f;
//    self.titleIconImageView.alpha = delta;
//    self.followButton.alpha = delta;
//    self.titleLabel.alpha = delta;
//
//    NSLog(@"%lf",offset);
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat height = _tableView.frame.size.height;
//    CGFloat distanceFromButton = _tableView.contentSize.height - _tableView.contentOffset.y;
//    if (distanceFromButton == height)
//    {
//        NSLog(@"=====滑动到底了");
//    }
//    if (_tableView.contentOffset.y == 0)
//    {
//        NSLog(@"=====滑动到顶了");
//    }
    
    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta = offset / 130.f;
    self.titleIconImageView.alpha = delta;
    self.followButton.alpha = delta;
    self.titleLabel.alpha = delta;
}

-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)followButtonClick{
    [self follow];
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
        [tableView registerClass:[SCCHomeTableViewCell class] forCellReuseIdentifier:CellID];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
        tableView.mj_footer.automaticallyHidden = YES;
        
        tableView.rowHeight = SCCWidth(300);
        //
        SCCAuthorInterfaceHeaderView *view = [[SCCAuthorInterfaceHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SCCWidth(130))];
        __weak typeof(self)weakSelf = self;
        [view setFollowButtonClickBlock:^{
            __strong typeof(self)strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf follow];
            }
        }];
        
        tableView.tableHeaderView = view;
        self.headerView = view;
        
        //        tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.backgroundColor = SCCBgColor;
        
        _tableView = tableView;
        
    }
    return _tableView;
}

- (UIView *)titleView{
    if(!_titleView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = SCCBgColor;
        [self.view addSubview:view];
        _titleView = view;
    }
    return _titleView;
}
- (UIImageView *)titleIconImageView{
    if(!_titleIconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius = 20;
        imageV.layer.masksToBounds = YES;
        [self.titleView addSubview:imageV];
        _titleIconImageView = imageV;
    }
    return _titleIconImageView;
}
- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:14 color:SCCColor(0x333333)];
        [self.titleView addSubview:lab];
        _titleLabel = lab;
    }
    return _titleLabel;
}
- (UIButton *)followButton{
    if(!_followButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"btn_follow"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(followButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
        _followButton = btn;
    }
    return _followButton;
}
- (UIButton *)backButton{
    if(!_backButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"exit_btn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"exit_btn"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
        _backButton = btn;
    }
    return _backButton;
}

-(void)dealloc{
    //第一种方法.这里可以移除该控制器下的所有通知
    // 移除当前所有通知
    NSLog(@"移除了所有的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
//    //第二种方法.这里可以移除该控制器下名称为tongzhi的通知
//    //移除名称为tongzhi的那个通知
//    NSLog(@"移除了名称为tongzhi的通知");
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tongzhi" object:nil];
}


@end
