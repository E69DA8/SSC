//
//  SCCVideoViewController.m
//  SCC
//
//  Created by E69DA8 on 2019/1/4.
//  Copyright © 2019年 E69DA8. All rights reserved.
//

#import "SCCVideoViewController.h"
#import "SCCHomeHeaderView.h"
#import "SCCVideoTableViewCell.h"
#import "SCCVideoModel.h"
#import "SCCVideoPlayViewController.h"

static NSString *CellID = @"SCCVideoTableViewCellID";
@interface SCCVideoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)SCCHomeHeaderView *headerView;//headerView
@property(weak,nonatomic) UITableView *tableView;//tableView

@end

@implementation SCCVideoViewController{
    NSArray<SCCVideoModel *> *_modelListArr;
    NSString *_iconPatn;
    NSString *_pictruePatn;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //    self.tabBarController.tabBar.hidden = YES;
}

-(void)loadData{

    [[SCCNetworkTool sharedNetworkTool] requestVideoListCallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            NSDictionary *dictData = dict[@"result"];
            
            _modelListArr = [NSArray yy_modelArrayWithClass:[SCCVideoModel class] json:dictData[@"infoList"]];
            
            _iconPatn = dictData[@"path"];
            _pictruePatn = dictData[@"pictruepath"];
            
            [self.tableView reloadData];
            
            //            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            //            self.tableView.mj_footer.state = MJRefreshStateIdle;
            //            [self.tableView.mj_footer resetNoMoreData];
            //            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
            
        }else{
            if (!dict[@"message"]) {
                [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
            }
            
        }
    }];
}

-(void)setupUI{
    
    [self loadData];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        //        make.top.equalTo(self.view).offset()
        make.top.offset(TopStatusHeight);
    }];
    
    self.view.backgroundColor = SCCBgColor;
    
    self.headerView.titleStr = @"视频";
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//        return 2;
    return _modelListArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconPath = _pictruePatn;
    cell.model = _modelListArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCCVideoPlayViewController *view = [[SCCVideoPlayViewController alloc]init];
    [self presentViewController:view animated:YES completion:nil];
    view.videoUrl = [NSString stringWithFormat:@"%@%@",_iconPatn,_modelListArr[indexPath.row].video_url];
    NSLog(@"%@-------%@",_iconPatn,_modelListArr[indexPath.row].video_url);
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
        [tableView registerClass:[SCCVideoTableViewCell class] forCellReuseIdentifier:CellID];
//        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData:)];
        
        tableView.mj_footer.automaticallyHidden = YES;
        
        tableView.rowHeight = SCCWidth(263);
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
