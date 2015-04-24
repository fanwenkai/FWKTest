//
//  ViewController.m
//  WKWeiBo
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "LoginViewController.h"
#import <Reachability.h>
#import "AppDelegate.h"

@interface LoginViewController ()<UIWebViewDelegate>
@property (strong,nonatomic) UIWebView *webView;
@end


@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self checkNetworkingStatu];
    [self loadWebView];
}
#pragma mark - 加载WebView
- (void)loadWebView
{
    self.webView = [UIWebView newAutoLayoutView];
    [self.view addSubview:self.webView];
    //添加约束
    [self.webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    //授权URL
    NSString *ssoPath = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code&display=mobile",APPKEY,REDIRECT_URL];
    //创建url连接
    NSURL* url = [NSURL URLWithString:ssoPath];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
}
#pragma mark - UIWebView的代理方法
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*) request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.获得请求地址
    NSString *urlStr = request.URL.absoluteString;
    //urlStr在字符串中的范围
    //设置从等号位置开始，不用再额外的找位置
    NSRange range=[urlStr rangeOfString:@"https://api.weibo.com/oauth2/default.html?code="];
    //判断是否为回调地址
     if (range.location!=NSNotFound)
     {//是回调地址
       //截取授权成功后的请求标记
         unsigned long from=range.location+range.length;
         NSString *code=[urlStr substringFromIndex:from];
         NSLog(@"code:%@--------------------",code);
         //根据code获得一个accessToken
         [self accessTokenWithCode:code];
         //禁止加载回调页面，拿到想要的东西就好了。
         return NO;
     }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView*)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)accessTokenWithCode:(NSString *)code
{
    [[WONetwork getInstance] requestAccessToken:[[WONetwork getInstance] woManager]
                                       clientId:APPKEY
                                   clientSecret:APPSECRET
                                      grantType:@"authorization_code"
                                           code:code
                                    redirectUri:REDIRECT_URL
                                       callBack:^(GKResponse *result) {//块中执行请求过后的语句
                                           if (result.ret == RET_SUCCESSED)
                                           {
                                               //请求成功，在此进行页面跳转
                                               NSLog(@"成功");
                                               [self.navigationController popViewControllerAnimated:YES];
                                           }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
