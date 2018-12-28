//
//  SCCMyLikeViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/11/18.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCMyLikeViewController.h"
#import "SCCHomeTableViewCell.h"
#import "SCCHomeViewModel.h"
#import "SCCArticleDetailsViewController.h"

static NSString *CellID = @"SCCMyLikeTableViewCellID";

@interface SCCMyLikeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)UITableView *tableView;
@end

@implementation SCCMyLikeViewController{
    NSArray<SCCHomeViewModel *> *_listModelArr;
    NSString *_iconPatn;
    NSInteger _page;
}

- (void)setupUI{
    
    
    
    self.view.backgroundColor = SCCBgColor;
//    self.tableView.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCCWidth(20));
        make.left.right.bottom.equalTo(self.view);
    }];

    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)loadData{
    _page = 1;
    NSDictionary *param = @{
                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                            @"pageNum" : @"1"
                            };
    
    [[SCCNetworkTool sharedNetworkTool]requestLikeArticleWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _listModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"articleList"]];
            
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
    
    NSDictionary *param = @{
                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                            @"pageNum" : [NSString stringWithFormat:@"%zd",_page + 1]
                            };
    
    [[SCCNetworkTool sharedNetworkTool]requestLikeArticleWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSDictionary *dictData = dict[@"result"];
            
            _page  = _page + 1;
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            [arrM addObjectsFromArray:_listModelArr];
            NSArray *newModelArr = [NSArray yy_modelArrayWithClass:[SCCHomeViewModel class] json:dictData[@"articleList"]];
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
    return _listModelArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconPath = _iconPatn;
    cell.model = _listModelArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCArticleDetailsViewController *detail = [[SCCArticleDetailsViewController alloc]init];
    detail.iconPath = _iconPatn;
    detail.articleId = _listModelArr[indexPath.row].articleId;
    detail.isThumbsUp = 1;
//    detail.isThumbsUp
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
        tableView.mj_footer.automaticallyHidden = YES;
        
        tableView.rowHeight = SCCWidth(300);
//        tableView.rowHeight = UITableViewAutomaticDimension;
//        tableView.estimatedRowHeight = SCCWidth(79);
        
//        tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.backgroundColor = SCCBgColor;
        
        _tableView = tableView;
        
    }
    return _tableView;
}

@end
