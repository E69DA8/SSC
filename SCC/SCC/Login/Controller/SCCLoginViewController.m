//
//  SCCLoginViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/11/30.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCLoginViewController.h"
#import "SCCHomeHeaderView.h"
#import "SCCRegisterViewController.h"
#import "AppDelegate.h"

@interface SCCLoginViewController ()
@property(weak,nonatomic)SCCHomeHeaderView *headerView;//headerView
@property(weak,nonatomic)UILabel *nameTextLabel;
@property(weak,nonatomic)UILabel *passWordTextLabel;
@property(weak,nonatomic)UITextField *nameTextfield;
@property(weak,nonatomic)UITextField *passWordTextfield;
@property(weak,nonatomic)UIButton *loginButton;
@property(weak,nonatomic)UIButton *registerButton;
@property(weak,nonatomic)UIButton *closeButton;
@property(weak,nonatomic)UIView *separateView1;
@property(weak,nonatomic)UIView *separateView2;
@end

@implementation SCCLoginViewController

- (void)loginButtonClick{
    if (self.nameTextfield.text.length < 3 || self.nameTextfield.text.length > 10) {
        [JYHLSVProgressHUD showWithMsg:@"名字长度应为3-10字符"];
        return;
    }
    
    if (self.passWordTextfield.text.length < 3 || self.passWordTextfield.text.length > 18) {
        [JYHLSVProgressHUD showWithMsg:@"名字长度应为3-18字符"];
        return;
    }
    
    NSDictionary *param = @{
                            @"userName" : self.nameTextfield.text,
                            @"passWord" : self.passWordTextfield.text
                            };
    [[SCCNetworkTool sharedNetworkTool] requestLoginWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            //            NSDictionary *dictData = dict[@"result"];
            
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"result"] forKey:SCCUserID];
            [[NSUserDefaults standardUserDefaults] setObject:self.nameTextfield.text forKey:SCCUserName];
            [[NSUserDefaults standardUserDefaults] setObject:self.passWordTextfield.text forKey:SCCUserPassword];
            
//            [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [JYHLSVProgressHUD showWithMsg:@"登录成功"];
                [MobClick event:@"logIn_log"];
                
            }];
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
    }];
}

-(void)registerButtonClick{
    SCCRegisterViewController *view = [[SCCRegisterViewController alloc]init];
    
    [self presentViewController:view animated:YES completion:nil];
}

-(void)closeButtonClick{
    
    if (self.type) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        UITabBarController *tabViewController = (UITabBarController *) appDelegate.window.rootViewController;
        
        [tabViewController setSelectedIndex:0];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

-(void)setupUI{
    self.headerView.titleStr = @"登录";
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCCWidth(40));
        make.left.right.equalTo(self.view);
        make.height.offset(SCCWidth(77));
    }];
    
    [self.nameTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(SCCWidth(20));
        make.top.equalTo(self.headerView.mas_bottom).offset(SCCWidth(75));
        make.width.offset(50);
    }];
    
    [self.nameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameTextLabel);
        make.left.equalTo(self.nameTextLabel.mas_right);
        make.right.equalTo(self.view.mas_right).offset(-SCCWidth(20));
    }];
    
    [self.separateView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextLabel.mas_bottom).offset(SCCWidth(10));
        make.left.equalTo(self.nameTextLabel.mas_left);
        make.right.equalTo(self.nameTextfield.mas_right);
        make.height.offset(0.5);
    }];
    
    [self.passWordTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.separateView1.mas_bottom).offset(SCCWidth(20));
        make.left.equalTo(self.nameTextLabel);
    }];
    
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passWordTextLabel);
        make.left.right.equalTo(self.nameTextfield);
    }];
    
    [self.separateView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWordTextLabel.mas_bottom).offset(SCCWidth(10));
        make.left.right.equalTo(self.separateView1);
        make.height.offset(0.5);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.separateView2.mas_bottom).offset(SCCWidth(30));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(335), SCCWidth(45)));
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).offset(SCCWidth(20));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(335), SCCWidth(45)));
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SCCWidth(50));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserName];
    NSString *userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserPassword];
    
    if ( userName.length > 0 & userPassword.length >0) {
        
        self.nameTextfield.text = userName;
        self.passWordTextfield.text = userPassword;
        
    }

    
    self.passWordTextfield.secureTextEntry = YES;
}

#pragma mark - 懒加载
- (UILabel *)nameTextLabel{
    if(!_nameTextfield){
        UILabel *lab = [UILabel r_labelWithText:@"用户名" fontSize:14 color:SCCColor(0x333333)];
        [self.view addSubview:lab];
        _nameTextLabel = lab;
    }
    return _nameTextLabel;
}
- (UILabel *)passWordTextLabel{
    if(!_passWordTextLabel){
        UILabel *lab = [UILabel r_labelWithText:@"密码" fontSize:14 color:SCCColor(0x333333)];
        [self.view addSubview:lab];
        _passWordTextLabel = lab;
    }
    return _passWordTextLabel;
}
- (UITextField *)nameTextfield{
    if(!_nameTextfield){
        UITextField *textField = [[UITextField alloc]init];
        textField.font = [UIFont systemFontOfSize:17];
        //        field1.background = [UIImage imageNamed:@"textBox"];
        textField.backgroundColor = [UIColor whiteColor];
        textField.textColor = SCCColor(0x333333);
        
        textField.keyboardType = UIKeyboardTypeDefault;
        //输入框 " × " 号一次性删除内容的
        textField.clearButtonMode = UITextFieldViewModeAlways;
        
        textField.placeholder = @"起个名字吧";
        textField.leftViewMode = UITextFieldViewModeAlways;
        UIView *field1View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        //        field1View.frame = CGRectMake(0, 0, 30, 30);
        textField.leftView = field1View;
        //设置UITextField的边框的风格
        //        field1.borderStyle = UITextBorderStyleRoundedRect;
        
        [textField setValue:[UIColor r_colorWithHex:0xe5e5e5] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
        [textField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
//        textField.delegate = self;
        [self.view addSubview:textField];
        _nameTextfield = textField;
    }
    return _nameTextfield;
}
- (UITextField *)passWordTextfield{
    if(!_passWordTextfield){
        UITextField *textField = [[UITextField alloc]init];
        textField.font = [UIFont systemFontOfSize:17];
        //        field1.background = [UIImage imageNamed:@"textBox"];
        textField.backgroundColor = [UIColor whiteColor];
        textField.textColor = SCCColor(0x333333);
        
        textField.keyboardType = UIKeyboardTypeDefault;
        //输入框 " × " 号一次性删除内容的
        textField.clearButtonMode = UITextFieldViewModeAlways;
        
        textField.placeholder = @"请输入密码";
        textField.leftViewMode = UITextFieldViewModeAlways;
        UIView *field1View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        //        field1View.frame = CGRectMake(0, 0, 30, 30);
        textField.leftView = field1View;
        //设置UITextField的边框的风格
        //        field1.borderStyle = UITextBorderStyleRoundedRect;
        
        [textField setValue:[UIColor r_colorWithHex:0xe5e5e5] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
        [textField setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
        //        textField.delegate = self;
        [self.view addSubview:textField];
        _passWordTextfield = textField;
    }
    return _passWordTextfield;
}
- (UIButton *)loginButton{
    if(!_loginButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        btn.backgroundColor = SCCColor(0x333333);
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _loginButton = btn;
    }
    return _loginButton;
}

- (UIButton *)registerButton{
    if(!_registerButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        [btn setTitleColor:SCCColor(0x333333) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 10;
        btn.layer.borderColor = SCCColor(0x333333).CGColor;
        btn.layer.borderWidth = 0.5;
        [btn addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _registerButton = btn;
    }
    return _registerButton;
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

- (UIView *)separateView1{
    if(!_separateView1){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = SCCColor(0xe5e5e5);
        [self.view addSubview:view];
        _separateView1 = view;
    }
    return _separateView1;
}

- (UIView *)separateView2{
    if(!_separateView2){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = SCCColor(0xe5e5e5);
        [self.view addSubview:view];
        _separateView2 = view;
    }
    return _separateView2;
}

- (SCCHomeHeaderView *)headerView{
    if(!_headerView){
        SCCHomeHeaderView *view = [[SCCHomeHeaderView alloc]init];
        [self.view addSubview:view];
        _headerView = view;
    }
    return _headerView;
}

@end
