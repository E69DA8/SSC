//
//  SCCShareViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/11/30.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCShareViewController.h"
#import "SCCShareCustomModal.h"
#import "AppDelegate.h"

@interface SCCShareViewController ()
@property (weak, nonatomic) UILabel *titleLbl;



@property (weak, nonatomic) UIButton *weChatBtn;

@property (weak, nonatomic) UIButton *wxTimeLine;

// QQ
@property (weak, nonatomic) UIButton *qqBtn;
// QQ 空间
@property (weak, nonatomic) UIButton *qzoneBtn;


@property (weak, nonatomic) UIView *bottomLine;

@property (weak, nonatomic) UIButton *cancelBtn;
@end

@implementation SCCShareViewController{
    SCCShareCustomModal *_customModal;
}

- (instancetype)init{
    if(self = [super init]){
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        _customModal = [[SCCShareCustomModal alloc]init];
        self.transitioningDelegate = _customModal;
        
        
        
        
    }
    return self;
}

-(void)setupUI{
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(25);
    }];
    CGFloat bottomMargin = isIPhoneX ? 20 : 0;
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomMargin);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.cancelBtn);
        make.bottom.equalTo(self.cancelBtn.mas_top);
        make.height.mas_equalTo(1);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    if(self.isOnlyWeChat){
//
//
        [self.weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).multipliedBy(0.5);
            make.bottom.equalTo(self.bottomLine.mas_top).offset(-18);
        }];

        [self.wxTimeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.weChatBtn);
            make.centerX.equalTo(self.view).multipliedBy(1.5);
        }];
//
//
//    }else{
    
        //    [self loadData];
//        NSArray *btnArr = @[self.weChatBtn,self.wxTimeLine,self.qqBtn,self.qzoneBtn];
//        //    NSArray *btnArr = @[self.qqBtn,self.qzoneBtn];
//        //    [btnArr mas_distributeSudokuViewsWithFixedItemWidth:self.qqBtn.bounds.size.width fixedItemHeight:self.qqBtn.bounds.size.height fixedLineSpacing:0 fixedInteritemSpacing:0 warpCount:4 topSpacing:0 bottomSpacing:0 leadSpacing:0 tailSpacing:0];
//
//        [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
//        [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
//            //            make.top.equalTo(self.view);
//            make.bottom.equalTo(self.bottomLine.mas_top).offset(-18);
//        }];
//    }
    
    
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击事件
- (void)shareBtnClick:(UIButton *)btn{
    UMSocialPlatformType type;
    
    switch (btn.tag) {
        case 1:
            type = UMSocialPlatformType_WechatSession;
            break;
        case 2:
            type = UMSocialPlatformType_WechatTimeLine;
            break;
        case 3:
            type = UMSocialPlatformType_QQ;
            break;
        case 4:
            type = UMSocialPlatformType_Qzone;
            break;
        default:
            type = UMSocialPlatformType_UnKnown;
            break;
    }
    
    NSDictionary *param = @{
                            @"articleId" : self.articleId
                            };
    
    [[SCCNetworkTool sharedNetworkTool] requestShareWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            NSString *url = dict[@"result"];
            
            if (self.shareClickBlock) {
                self.shareClickBlock(btn.tag, url);
            }
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
        
    }];
    
    
    
}


#pragma mark - 懒加载
- (UIButton *)weChatBtn{
    if(_weChatBtn == nil){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = 1;
        
        [btn setImage:[UIImage imageNamed:@"buytogether_wechat_share_icon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        _weChatBtn = btn;
    }
    return _weChatBtn;
}

- (UIButton *)wxTimeLine{
    if(_wxTimeLine == nil){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = 2;
        
        [btn setImage:[UIImage imageNamed:@"buytogether_moments_share_icon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        _wxTimeLine = btn;
    }
    return _wxTimeLine;
}

- (UIButton *)qqBtn{
    if(_qqBtn == nil){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 3;
        [btn setImage:[UIImage imageNamed:@"share_QQ"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _qqBtn = btn;
    }
    return _qqBtn;
}

- (UIButton *)qzoneBtn{
    if(_qzoneBtn == nil){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 4;
        [btn setImage:[UIImage imageNamed:@"share_QQspace"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _qzoneBtn = btn;
    }
    return _qzoneBtn;
}

- (UILabel *)titleLbl{
    if(_titleLbl == nil){
        UILabel *lbl = [UILabel r_labelWithText:@"分享到" fontSize:16 color:[UIColor r_colorWithHex:0x666666]];
        [self.view addSubview:lbl];
        _titleLbl = lbl;
    }
    return _titleLbl;
}
- (UIView *)bottomLine{
    if(_bottomLine == nil){
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor r_colorWithHex:0xe5e5e5];
        [self.view addSubview:v];
        _bottomLine = v;
    }
    return _bottomLine;
}
- (UIButton *)cancelBtn{
    if(_cancelBtn == nil){
        UIButton *b = [ UIButton r_textButton:@"取消" fontSize:16 normalColor:[UIColor r_colorWithHex:0x1a1a1a] selectedColor:nil];
        [b addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:b];
        _cancelBtn = b;
    }
    return _cancelBtn;
}

@end
