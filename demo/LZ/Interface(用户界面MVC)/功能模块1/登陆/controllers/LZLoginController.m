//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZLoginController.h"
#import "LZLoginManager.h"
@interface LZLoginController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *userNameTf;/** 账号  */

@property(nonatomic, strong)UITextField *passwordTf;/** 密码  */

@property(nonatomic, strong)UIButton *loginBtn;/** 登陆按钮  */

@property(nonatomic, strong)UIView *line;/** 线  */
@end

@implementation LZLoginController

#pragma mark ************** 懒加载控件
- (UIButton *)loginBtn{
    
    if(!_loginBtn){
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.backgroundColor = mainColor;
        _loginBtn.layer.cornerRadius=3;
        _loginBtn.layer.masksToBounds=YES;
        [_loginBtn setTitle:@"登陆" forState:0];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _loginBtn;
}
- (UITextField *)userNameTf{
    
    if(!_userNameTf){
        _userNameTf = [[UITextField alloc]init];
        _userNameTf.textColor = [UIColor blackColor];
        _userNameTf.backgroundColor = [UIColor whiteColor];
        _userNameTf.font = [UIFont boldSystemFontOfSize:18.0f];
        _userNameTf.clearButtonMode=YES;
        _userNameTf.keyboardType=UIKeyboardTypeNumberPad; //设置键盘样式
        _userNameTf.placeholder=@"手机号/邮箱";
        _userNameTf.textAlignment = NSTextAlignmentCenter;//文本居中
    }
    
    return _userNameTf;
}
- (UITextField *)passwordTf
{
    if(!_passwordTf)
    {
        _passwordTf = [[UITextField alloc]init];
        _passwordTf.backgroundColor = [UIColor whiteColor];
        _passwordTf.delegate = self;//设置代理
        _passwordTf.clearButtonMode=YES;//设置清除按钮
        _passwordTf.keyboardType=UIKeyboardTypeDefault; //设置键盘样式
        _passwordTf.secureTextEntry=YES; //文本框文字是否保密
        _passwordTf.placeholder=@"密码";
        _passwordTf.textAlignment = NSTextAlignmentCenter;
        _passwordTf.font = [UIFont boldSystemFontOfSize:18.0f];
        _passwordTf.returnKeyType = UIReturnKeyJoin; // 设置return样色，登陆时使用
    }
    
    return _passwordTf;
}

- (UIView *)line{
    
    if(!_line){
        _line = [[UIView alloc]init];
        _line.backgroundColor = RGBA(236, 237, 241, 1);
    }
    
    return _line;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.view.backgroundColor = RGB(231 ,233, 237);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show_Action:) name:UIKeyboardWillShowNotification object:nil];//键盘显示时的方法
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide_Action:) name:UIKeyboardWillHideNotification object:nil];//键盘隐藏时的方法
}
#pragma mark ************** 点击登陆
- (void)loginAction
{
    [LZLoginManager savePhoneNumWithString:@"15819953627"];//保存电话号码
    
    [self jumpToHomeViewController];//跳转到tabBarController
}

#pragma mark **************** 跳转到tabBarController
- (void)jumpToHomeViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //配置tabBarController
    LZTabBarControllerConfig *tabBarControllerConfig = [[LZTabBarControllerConfig alloc] init];
    [window setRootViewController:tabBarControllerConfig.tabBarController];
    
}


#pragma mark ************** 键盘显示通知
-(void)show_Action:(NSNotification *)sender
{
    //view 向上移动
    NSLog(@"userinfo = %@",sender.userInfo);
    
    NSValue *value = sender.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue]; //获取键盘的高度
    
    CGFloat loginBtn_h = self.loginBtn.frame.size.height+self.loginBtn.frame.origin.y;
    
    if (rect.origin.y < loginBtn_h) {
        
        [UIView animateWithDuration:0.3 animations:^(){
            
            self.view.frame = CGRectMake(0, rect.origin.y-loginBtn_h-10, SCREEN_WIDTH, SCREEN_HEIGHT);
            
        } completion:nil];
    }
}
#pragma mark ************** 键盘隐藏通知
-(void)hide_Action:(NSNotification *)sender
{
    //view 向下移动
    [UIView animateWithDuration:0.3 animations:^(){
        
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT);
        
    } completion:nil];
}

#pragma mark ************** 点击屏幕
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];//结束编辑
}
#pragma mark ************** 移除通知的接受者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.userNameTf];
    [self.view addSubview:self.passwordTf];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.line];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_userNameTf makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(50));
        make.top.equalTo(self.view).offset((SCREEN_HEIGHT/10*3));
        make.left.right.equalTo(self.view);
    }];
    [_line makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(0.5));
        make.top.equalTo(_userNameTf.bottom);
        make.left.right.equalTo(self.view);
    }];
    [_passwordTf makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(50));
        make.top.equalTo(_userNameTf.bottom);
        make.left.right.equalTo(self.view);
    }];
    
    [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(50));
        make.top.equalTo(_passwordTf.bottom).offset(15);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
    }];
}
@end
