//
//  SCCRegisterViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/11/30.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCRegisterViewController.h"
#import "SCCHomeHeaderView.h"
#import "JYHLUserAgreementWebViewController.h"
@interface SCCRegisterViewController ()
@property(weak,nonatomic)SCCHomeHeaderView *headerView;//headerView
@property(weak,nonatomic)UILabel *nameTextLabel;
@property(weak,nonatomic)UILabel *passWordTextLabel;
@property(weak,nonatomic)UITextField *nameTextfield;
@property(weak,nonatomic)UITextField *passWordTextfield;
@property(weak,nonatomic)UIButton *registerButton;
@property(weak,nonatomic)UIButton *closeButton;
@property(weak,nonatomic)UIView *separateView1;
@property(weak,nonatomic)UIView *separateView2;
@property(weak,nonatomic)UILabel *protocolLabel;
@property(weak,nonatomic)UIButton *protocolButton;
@end

@implementation SCCRegisterViewController

- (void)protocolButtonClick{
    JYHLUserAgreementWebViewController *concealVC = [[JYHLUserAgreementWebViewController alloc]init];
    
    concealVC.title = @"服务条款";
    concealVC.urlStr = @"http://lookroe.com/yhxy.html";
    [self presentViewController:concealVC animated:YES completion:nil];
}

-(void)registerButtonClick{
    
    if (self.nameTextfield.text.length < 3 || self.nameTextfield.text.length > 10) {
        [JYHLSVProgressHUD showWithMsg:@"名字长度应为3-10字符"];
        return;
    }
    
    if (![self checkPassword:self.passWordTextfield.text]) {
        [JYHLSVProgressHUD showWithMsg:@"密码应为6-18位数字和字母组合"];
        return;
    }
    
    NSDictionary *param = @{
                            @"userName" : self.nameTextfield.text,
                            @"passWord" : self.passWordTextfield.text
                            };
    [[SCCNetworkTool sharedNetworkTool] requestRegisterWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
//            NSDictionary *dictData = dict[@"result"];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [JYHLSVProgressHUD showWithMsg:@"注册成功，请登录"];
                [MobClick event:@"logIn_register" label:@"注册成功"];
            }];
            
        }else{
            [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
        }
    }];
}

-(void)closeButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupUI{
    self.headerView.titleStr = @"注册";
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
    
   
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.separateView2.mas_bottom).offset(SCCWidth(30));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(335), SCCWidth(45)));
    }];
    
    [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).offset(SCCWidth(20));
        make.right.equalTo(self.view.mas_centerX).offset(SCCWidth(-10));
    }];
    
    [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.protocolLabel);
        make.left.equalTo(self.protocolLabel.mas_right);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-SCCWidth(50));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];
    
}

- (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
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

- (UIButton *)registerButton{
    if(!_registerButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        btn.backgroundColor = SCCColor(0x333333);
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
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

- (UILabel *)protocolLabel{
    if(!_protocolLabel){
        UILabel *lab = [UILabel r_labelWithText:@"注册即代表同意" fontSize:14 color:SCCColor(0x333333)];
        [self.view addSubview:lab];
        _protocolLabel = lab;
    }
    return _protocolLabel;
}

- (UIButton *)protocolButton{
    if(!_protocolButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"《股评家服务条款》" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(protocolButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _protocolButton = btn;
    }
    return _protocolButton;
}

@end
