//
//  SCCHomeViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/23.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCHomeViewController.h"
#import "SCCHomeTableViewCell.h"
#import "SCCHomeHeaderView.h"
#import "SCCArticleDetailsViewController.h"
#import "SCCAuthorInterfaceViewController.h"
#import "SCCHomeViewModel.h"
#import "SCCLoginViewController.h"

static NSString *CellID = @"SCCHomeTableViewCellID";
@interface SCCHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)SCCHomeHeaderView *headerView;//headerView

@end

@implementation SCCHomeViewController{
    NSIndexPath *selectIndexPath;
    NSArray<SCCHomeViewModel *> *_listModelArr;
    NSString *_iconPatn;
    NSInteger _page;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self loadData];
    [MobClick event:@"article_list"];
//    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}


-(void)setupUI{
    
    _page = 1;
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //    self.tableView.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);;
    
    self.view.backgroundColor = SCCBgColor;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(self.view).offset()
        make.top.offset(TopStatusHeight);
    }];
    
    self.headerView.titleStr = @"推荐";
    
    
}

-(void)loadData{
    
    NSString *paramStr;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
        paramStr = [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID];
    }else{
        paramStr = @"-1";
    }
    
    NSDictionary *param = @{
                            @"userId" : paramStr,
                            @"pageNum" : @"1"
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestArticleListWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
      
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"infoList"]];
            
            _iconPatn = dictData[@"path"];
            
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
    
    NSString *paramStr;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
        paramStr = [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID];
    }else{
        paramStr = @"-1";
    }
    
    NSDictionary *param = @{
                            @"userId" : paramStr,
                            @"pageNum" : [NSString stringWithFormat:@"%zd",_page + 1]
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestArticleListWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }

        
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _page  = _page + 1;
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            [arrM addObjectsFromArray:_listModelArr];
            NSArray *newModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"bannerList"]];
            _listModelArr = [arrM arrayByAddingObjectsFromArray:newModelArr];
            
            [self.tableView reloadData];
            [footer endRefreshing];
        }else{
            [footer endRefreshingWithNoMoreData];
        }
        
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _arrList.count;
    return _listModelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.model = _arrList[indexPath.row];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
//        cell.type = 0;
//    }else{
//        cell.type = 1;
//    }
    cell.iconPath = _iconPatn;
    cell.model = _listModelArr[indexPath.row];
    
    
    
    __weak typeof(self)weakSelf = self;
    [cell setHomeCellButtonClickBlock:^(NSInteger type) {
        __strong typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            
            if (type == 2) {
                SCCAuthorInterfaceViewController *view = [[SCCAuthorInterfaceViewController alloc]init];
                view.autherId = _listModelArr[indexPath.row].autherId;
                view.isThumbsUp = _listModelArr[indexPath.row].isThumbsUp;
                [strongSelf.navigationController pushViewController:view animated:YES];
            }else if (type == 1){
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
                    
                    NSDictionary *param = @{
                                            @"authorId" : _listModelArr[indexPath.row].autherId,
                                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                                            @"remark": _listModelArr[indexPath.row].is_follow == 1 ? @"0" : @"1"
                                            };
                    
                    
                    NSLog(@"---------%@--------",param);
                    
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
            
        }
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    detail.isThumbsUp = _listModelArr[indexPath.row].isThumbsUp;
    detail.isFollow = _listModelArr[indexPath.row].is_follow;
    [self presentViewController:detail animated:YES completion:nil];
    
    
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

        tableView.rowHeight = SCCWidth(300);
        //
        SCCHomeHeaderView *view = [[SCCHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SCCWidth(77))];
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

@end
