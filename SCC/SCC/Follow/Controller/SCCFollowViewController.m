//
//  SCCFollowViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/25.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCFollowViewController.h"
#import "SCCFollowTableViewCell.h"
#import "SCCHomeHeaderView.h"
#import "SCCNoFollowModel.h"
#import "SCCLoginViewController.h"
#import "SCCHomeViewModel.h"
#import "SCCHomeTableViewCell.h"
#import "SCCAuthorInterfaceViewController.h"
#import "SCCArticleDetailsViewController.h"

static NSString *CellID = @"SCCFollowTableViewCellID";
static NSString *CellID2 = @"SCCHomeTableViewCellID2";


@interface SCCFollowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic) UITableView *tableView;//tableView

@property(strong,nonatomic)SCCHomeHeaderView *headerView;//headerView

@end

@implementation SCCFollowViewController{
    NSArray<SCCNoFollowModel *> *_listModelArr;
    NSArray<SCCHomeViewModel *> *_followListModelArr;
    NSString *_iconPatn;//头像前缀
    NSInteger _type ;//1:有关注，2：没有关注
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadIsFollowData];
}

- (void)setupFoloowUI{
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    self.tableView.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        //        make.top.equalTo(self.view).offset()
        make.top.offset(TopStatusHeight);
    }];
    
    self.view.backgroundColor = SCCBgColor;
    
    self.headerView.titleStr = @"关注";
}

-(void)loadIsFollowData{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
        
        NSDictionary *param = @{
                                @"userId": [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID]
                                    };
        
        [[SCCNetworkTool sharedNetworkTool] requestIsFollownWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
            
            if (error) {
                [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
                return ;
            }
            
            if ([dict[@"state"] isEqualToString:@"success"]) {
                
                if ([dict[@"result"] integerValue] ) {
                    _type = 1;
                    [self loadData];
                }else{
                    _type = 2;
                    [self loadNoData];
                }
                
                if (_type == 1) {
                    self.tableView.rowHeight = SCCWidth(280);
                }else if (_type == 2){
                    self.tableView.rowHeight = SCCWidth(79);
                }
                
                [self setupFoloowUI];
                
            }else{
                [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
                
            }
            
        }];
    }else{
        
        SCCLoginViewController *view = [[SCCLoginViewController alloc]init];
        view.type = 1;
        [self presentViewController:view animated:YES completion:nil];
    }
    
   
}

-(void)loadData{
    NSDictionary *param = @{
                            @"userId": [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID]
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestFollowListWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _followListModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"followList"]];
            
            _iconPatn = dictData[@"path"];
            
            [self.tableView reloadData];
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
        
    }];
}


-(void)loadNoData{
    [[SCCNetworkTool sharedNetworkTool] requestNoFollowListWithParam:nil CallBack:^(NSDictionary *dict, NSError *error) {
        
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _listModelArr = [NSArray yy_modelArrayWithClass:[SCCNoFollowModel class] json:dictData[@"unfollowList"]];
            
            _iconPatn = dictData[@"path"];
            
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
    //    return _arrList.count;
    
    if (_type == 1) {
        return _followListModelArr.count;
    }else {
        return _listModelArr.count;
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_type == 1) {
        SCCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    cell.model = _arrList[indexPath.row];
        cell.iconPath = _iconPatn;
        cell.model = _followListModelArr[indexPath.row];
        
        __weak typeof(self)weakSelf = self;
        [cell setHomeCellButtonClickBlock:^(NSInteger type) {
            __strong typeof(self)strongSelf = weakSelf;
            if (strongSelf) {
                
                if (type == 2) {
                    SCCAuthorInterfaceViewController *view = [[SCCAuthorInterfaceViewController alloc]init];
                    view.autherId = _listModelArr[indexPath.row].autherId;
                    [strongSelf.navigationController pushViewController:view animated:YES];
                }else if (type == 1){
                    
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID] integerValue] > 0) {
                        
                        NSDictionary *param = @{
                                                @"authorId" : _followListModelArr[indexPath.row].autherId,
                                                @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                                                @"remark": _followListModelArr[indexPath.row].is_follow == 1 ? @"0" : @"1"
                                                };
                        [[SCCNetworkTool sharedNetworkTool] requestFollowWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
                            if (error) {
                                [JYHLSVProgressHUD showWithMsg :error.localizedDescription];
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
                                
//                                [JYHLSVProgressHUD showWithMsg:@"关注成功"];
                                
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
                
            }
        }];
        
        return cell;
    }else {
        SCCFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconPath = _iconPatn;
        cell.model = _listModelArr[indexPath.row];
        __weak typeof(self)weakSelf = self;
        [cell setFollowButtonClickBlock:^{
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
                            
                            if (_listModelArr.count > 1) {
                                [self loadNoData];
                            }else{
                                [self loadIsFollowData];
                            }
                            
                            
                            
                            
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
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == 1) {
        SCCArticleDetailsViewController *detail = [[SCCArticleDetailsViewController alloc]init];
        
        detail.iconPath = _iconPatn;
        detail.articleId = _followListModelArr[indexPath.row].articleId;
        [self presentViewController:detail animated:YES completion:nil];
    }
    
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
        [tableView registerClass:[SCCFollowTableViewCell class] forCellReuseIdentifier:CellID];
        [tableView registerClass:[SCCHomeTableViewCell class] forCellReuseIdentifier:CellID2];
        
        
        tableView.rowHeight = SCCWidth(280);
            
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
