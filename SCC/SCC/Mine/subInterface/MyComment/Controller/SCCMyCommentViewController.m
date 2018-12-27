//
//  SCCMyCommentViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/26.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCMyCommentViewController.h"
#import "SCCMyCommentTableViewCell.h"
#import "SCCArticleCommentModel.h"
#import "SCCArticleDetailsViewController.h"

static NSString *CellID = @"SCCMyCommentTableViewCellID";
@interface SCCMyCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic) UITableView *tableView;//tableView

@end

@implementation SCCMyCommentViewController{
    NSString *_commentIconPath;
    NSArray<SCCArticleCommentModel*> *_commentModelArr;
    NSInteger _page;
}

- (void)setupUI{
    
    _page = 1;
    
    self.tableView.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}

-(void)loadData{
    NSDictionary *param = @{
                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                            @"articleId" :@"-1",
                            @"pageNum" : @"1"
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

/**
 *  上拉加载数据
 */
- (void)loadMoreData:(MJRefreshFooter *)footer{
    
    NSDictionary *param = @{
                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                            @"articleId" :@"-1",
                            @"pageNum" : [NSString stringWithFormat:@"%zd",_page + 1]
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestCommentListWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _page  = _page + 1;
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            [arrM addObjectsFromArray:_commentModelArr];
            NSArray *newModelArr = [NSArray yy_modelArrayWithClass:[SCCArticleCommentModel class] json:dictData[@"discussList"]];
            _commentModelArr = [arrM arrayByAddingObjectsFromArray:newModelArr];
            
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
        return _commentModelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCMyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.commentIconPath = _commentIconPath;
    cell.model = _commentModelArr[indexPath.row];
    __weak typeof(self)weakSelf = self;
    [cell setCommentThumbsUpButtonClickBlock:^{
        __strong typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            NSDictionary *param = @{
                                    @"discussId" : _commentModelArr[indexPath.row].discuss_id
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
                    [self loadData];
                    
                }else{
                    [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
                }
            }];
        }
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCArticleDetailsViewController *detail = [[SCCArticleDetailsViewController alloc]init];
    detail.iconPath = _commentIconPath;
    detail.articleId = _commentModelArr[indexPath.row].articleId;
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
        [tableView registerClass:[SCCMyCommentTableViewCell class] forCellReuseIdentifier:CellID];
        
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
        
//        tableView.rowHeight = SCCWidth(79);
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = SCCWidth(79);
        
//        tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.backgroundColor = SCCBgColor;
        
        _tableView = tableView;
        
    }
    return _tableView;
}


@end
