//
//  BaseViewController.m
//  WKWeiBo
//
//  Created by apple on 15/4/21.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "BaseViewController.h"
#import "RequestAccessTokenModel.h"
#import <Reachability.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface BaseViewController()
@property(strong,nonatomic) Reachability *reachs;
@end
static BOOL isLoginFlag = false;
@implementation BaseViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self login];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.reachs stopNotifier];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkNetworkingStatu];
}
#pragma mark - 获取Token
- (NSString *)getToken
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN_KEY];
    RequestAccessTokenModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"Token:%@",model.access_token);
    return model.access_token;
}
#pragma mark - 判断是否登录
- (BOOL)isLogin
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN_KEY];
    RequestAccessTokenModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"AccessToken:%@",model.access_token);
    if (model.access_token != Nil)
    {
        //登录过了
        isLoginFlag = true;
        return YES;
    }
    return NO;
}
#pragma mark - 登录
- (void)login
{
    if ([self isLogin] && isLoginFlag)
    {
        NSLog(@"已经登录过了");
        return ;
    }
    isLoginFlag = true;
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
#pragma mark - 提示方法
- (void)tipMethord
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"网络连接" message:@"请连接网络后再继续" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //完成后调用该block
    }];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:^{
        //完成后调用该方法
    }];
    
}
#pragma mark - 检测网络状态
- (void)checkNetworkingStatu
{
    self.reachs = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reachs startNotifier];
    
}
#pragma mark - 当网络状态变化时调用该方法
- (void) reachabilityChanged: (NSNotification*)note
{
    Reachability * reach = [note object];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if(![reach isReachable])
    {
        //网络不可用
        [self tipMethord];
        NSLog(@"网络不可用");
        [appDelegate.window makeToast:@"网络不可用"];
        return;
    }
    [appDelegate.window makeToast:@"连接到网络"];
}

@end
