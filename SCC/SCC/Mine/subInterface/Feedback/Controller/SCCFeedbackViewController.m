//
//  SCCFeedbackViewController.m
//  SCC
//
//  Created by E69DA8 on 2018/10/30.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCFeedbackViewController.h"

@interface SCCFeedbackViewController ()<UITextFieldDelegate>
@property(weak,nonatomic)UITextView *feedbackTxt;//评论
@end

@implementation SCCFeedbackViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)submissionFeedbackClick{
    
    if (self.feedbackTxt.text.length < 1) {
        return;
    }
    
    NSDictionary *param = @{
                            @"userId" : [[NSUserDefaults standardUserDefaults] objectForKey:SCCUserID],
                            @"suggestionContent" : self.feedbackTxt.text
                            };
    [[SCCNetworkTool sharedNetworkTool] requestSuggestionBackWithParam:param CallBack:^(NSDictionary *dict, NSError *error) {
        if (error) {
            [JYHLSVProgressHUD showWithMsg:error.localizedDescription];
            return ;
        }
        
        if ([dict[@"state"] isEqualToString:@"success"]) {
            
            [JYHLSVProgressHUD showWithMsg:@"反馈成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            if (!dict[@"message"]) {
                [JYHLSVProgressHUD showWithMsg:dict[@"message"]];
            }
        }
    }];
    
}

-(void)setupUI{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submissionFeedbackClick)];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.feedbackTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCCWidth(10));
        make.left.equalTo(self.view).offset(SCCWidth(20));
        make.right.equalTo(self.view).offset(SCCWidth(-20));
        make.bottom.equalTo(self.view);
    }];
    
    [self.feedbackTxt becomeFirstResponder];
}

- (UITextView *)feedbackTxt{
    if(_feedbackTxt == nil){
        UITextView *field1 = [[UITextView alloc]init];
        field1.font = [UIFont systemFontOfSize:16];
        
        field1.backgroundColor = [UIColor whiteColor];
        //设置UITextField的左边view出现模式
//        field1.leftViewMode = UITextFieldViewModeAlways;
//        UILabel *field1View = [UILabel r_labelWithText:@"持卡人" fontSize:15 color:[UIColor blackColor]];
//        field1View.frame = CGRectMake(0, 0, 66, 30);
//        field1View.textAlignment = NSTextAlignmentCenter;
//        field1.leftView = field1View;
        field1.keyboardType = UIKeyboardTypeDefault;
        //输入框 " × " 号一次性删除内容的
//        field1.clearButtonMode = UITextFieldViewModeAlways;
        
//        field1.placeholder = @"请输入您的宝贵意见。。。";
//        //设置UITextField的边框的风格
//        field1.borderStyle = UITextBorderStyleNone;
        [field1 setValue:[UIColor r_colorWithHex:0x939393] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
        [field1 setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
//        field1.delegate = self;
//        field1.layer.borderWidth = 0.5;
//        field1.layer.borderColor = [UIColor r_colorWithHex:0xd4d4d4].CGColor;
        field1.returnKeyType = UIReturnKeyDone;
        
//       field1.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;//文本居上
        
        [self.view addSubview:field1];
        _feedbackTxt = field1;
    }
    return _feedbackTxt;
}

@end
