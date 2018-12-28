//
//  JYHLUserAgreementWebViewController.m
//  JYHLLiveRoom
//
//  Created by Peter on 2018/2/1.
//  Copyright © 2018年 9yu. All rights reserved.
//

#import "JYHLUserAgreementWebViewController.h"
#import <WebKit/WebKit.h>
@interface JYHLUserAgreementWebViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) WKWebView *rankV;
@property (strong, nonatomic) UIProgressView *progressView;
@property(weak,nonatomic)UIButton *closeButton;//关闭
@end

@implementation JYHLUserAgreementWebViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.delegate = self;
}

-(void)closeButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 隐藏导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:NO];
}

- (void)goBack{
//    if([self.rankV canGoBack]){
//        [self.rankV goBack];
//
//        self.navigationItem.leftBarButtonItems = @[
//                                                   [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)],
//                                                   [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)]
//                                                   ];
//
//    }else{
//        [self closeNative];
//    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeNative{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)setupUI{
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"exit_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor r_colorWithHex:0xeeeeee];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.offset(6);
    }];
    
    [self.rankV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(view.mas_bottom);
    }];
    
    if(self.urlStr){
        [self.rankV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    }else{
        [JYHLSVProgressHUD showWithMsg:@"域名错误,请重新打开"];
    }
    
    
//    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(SCCWidth(40));
//        make.right.equalTo(self.view).offset(SCCWidth(-40));
//        make.size.mas_equalTo(CGSizeMake(SCCWidth(40), SCCWidth(40)));
//    }];
    
    
}






-(WKWebView *)rankV{
    if(_rankV == nil){
        //        UIView *v = [[UIView alloc]init];
        //        [self.view addSubview:v];
        WKWebView *wkWebV = [[WKWebView alloc]init];
        //        wkWebV.backgroundColor = [UIColor r_colorWithRed:245 green:235 blue:194];
        wkWebV.scrollView.bounces = NO;
        wkWebV.scrollView.showsHorizontalScrollIndicator = NO;
        //        CGSize contentSize = wkWebV.scrollView.contentSize;
        //        contentSize.width = 0;
        //        wkWebV.scrollView.contentSize = contentSize;
        //        wkWebV.delegate = self;
        //        wkWebV.scrollView.delegate = self;
        
        wkWebV.scrollView.showsVerticalScrollIndicator = NO;
        
        //        [self.view addSubview:wkWebV];
        [self.view insertSubview:wkWebV belowSubview:self.progressView];
        //        [wkWebV mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.edges.equalTo(v);
        //        }];
        
        [wkWebV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        
        
        
        
        
        _rankV = wkWebV;
    }
    return _rankV;
}

- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 6, ScreenWidth, 0)];
        self.progressView.tintColor = [UIColor redColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:self.progressView];
    }
    return _progressView;
}

- (void)dealloc{
    [self.rankV removeObserver:self forKeyPath:@"estimatedProgress"];
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.rankV && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
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


@end

