//
//  WONetwork.h
//  WKWeiBo
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GKResponse.h"
#import <AFNetworking.h>
#import "Utils.h"

typedef void(^SDK_CALLBACK) (GKResponse *result);

@interface WONetwork : NSObject
+ (WONetwork *)getInstance;
-(void)cancelAllRequest;
-(AFHTTPRequestOperationManager*) woManager;
@end

#pragma mark - 账户类
@interface WONetwork (UserAccount)
/**
 * 获取微博用户Token
 * @param clientId 申请应用时分配的AppKey。
 * @param clientSecret 申请应用时分配的AppSecret。
 * @param grantType 请求的类型，填写authorization_code时，参数code和redirectUri必须有值
 * @param code  调用authorize获得的code值。
 * @param redirectUri 回调地址，需需与注册应用里的回调地址一致。
 * @param callBack 发起请求时的回调函数
 */
- (NSOperation*)requestAccessToken:(AFHTTPRequestOperationManager *)manager clientId:(NSString *)clientId clientSecret:(NSString *)clientSecret grantType:(NSString *)grantType code:(NSString *)code redirectUri:(NSString *)redirectUri callBack:(SDK_CALLBACK)callBack;
/**
 *获取最新的公共微博
 * @param accessToken  用户Token
 * @param callBack 发起请求时的回调函数
 */
- (NSOperation *)requestPublicTimeLine:(AFHTTPRequestOperationManager *)manager accessToken:(NSString *)accessToken callBack:(SDK_CALLBACK)callBack;
@end
