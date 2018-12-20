//
//  SCCAboutViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/30.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCAboutViewController.h"

@interface SCCAboutViewController ()
@property(weak,nonatomic)UIImageView  *iconImageView;//appIcon
@property(weak,nonatomic)UILabel *versionlabel;//版本号
@end

@implementation SCCAboutViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)setupUI{
    self.view.backgroundColor = SCCBgColor;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCCWidth(80));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self.versionlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(SCCWidth(7));
        make.centerX.equalTo(self.iconImageView);
    }];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    CFShow((__bridge CFTypeRef)(infoDictionary));
    
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.iconImageView.image = [UIImage imageNamed:@"user_2"];
    self.versionlabel.text = [NSString stringWithFormat:@"v%@",appCurVersion];
    
}

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius = SCCWidth(20);
        imageV.layer.masksToBounds = YES;
        [self.view addSubview:imageV];
        _iconImageView = imageV;
    }
    return _iconImageView;
}

- (UILabel *)versionlabel{
    if(!_versionlabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:[UIColor blackColor]];
        [self.view addSubview:lab];
        _versionlabel = lab;
    }
    return _versionlabel;
}

@end
