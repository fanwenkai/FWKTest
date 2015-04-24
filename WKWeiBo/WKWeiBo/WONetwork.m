//
//  WONetwork.m
//  WKWeiBo
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "WONetwork.h"
#import "RequestAccessTokenResponse.h"
#import "FirstPublic_TimelineResponse.h"

@implementation WONetwork
{
    AFHTTPRequestOperationManager *_manager;
}
-(void)cancelAllRequest
{
    [_manager.operationQueue cancelAllOperations];
}
-(AFHTTPRequestOperationManager *)woManager
{
    return _manager;
}
+(WONetwork *)getInstance
{
    static WONetwork *_instance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _instance = [[WONetwork alloc] init];
    });
    
    return _instance;
}
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:HOST_NAME]];
        _manager.responseSerializer.acceptableContentTypes = nil;
//        _manager.requestSerializer = [ AFHTTPRequestSerializer serializer ];
//        _manager.responseSerializer = [ AFJSONResponseSerializer serializer ];
    }
    return self;
}

- (void) success:(id)responseObject
        response:(GKResponse*)response
        callback:(SDK_CALLBACK)callback
{
    if(![responseObject isKindOfClass:[NSDictionary class]])
    {
        response.ret = RET_DATA_FORMAT_ERROR;
        response.msg = @"服务器返回数据格式错误";
    }
    else
        [response fromDic:responseObject];
    callback(response);
}

- (void) failure:(NSError*)error
        response:(GKResponse*)response
        callback:(SDK_CALLBACK)callback
{
    if(error.code == -999) // 请求被取消，不要再调用客户端了
        return;
    
    response.ret = RET_HTTP_ERROR;

    response.msg = error.description;
    callback(response);
}

- (NSOperation*)get:(AFHTTPRequestOperationManager *)manager
                url:(NSString*)url
             params:(NSMutableDictionary*)params
           response:(GKResponse*)response
           callback:(SDK_CALLBACK)callback
{
    AFHTTPRequestOperation *operation = [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        [self success:responseObject
             response:response
             callback:callback];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self failure:error
             response:response
             callback:callback];
    }];
    return operation;
}

-(NSOperation*)post:(AFHTTPRequestOperationManager *)manager
                url:(NSString*)url
             params:(NSMutableDictionary*)params
           response:(GKResponse*)response
           callback:(SDK_CALLBACK)callback
{
    //    [self addTokenToParams:params];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self success:responseObject
             response:response
             callback:callback];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self failure:error
             response:response
             callback:callback];
    }];
    
    return operation;
}

@end
#pragma mark - 账户类
@implementation WONetwork (UserAccount)

- (NSOperation*)requestAccessToken:(AFHTTPRequestOperationManager *)manager clientId:(NSString *)clientId clientSecret:(NSString *)clientSecret grantType:(NSString *)grantType code:(NSString *)code redirectUri:(NSString *)redirectUri callBack:(SDK_CALLBACK)callBack
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:clientId forKey:@"client_id"];
    [dic setObject:clientSecret forKey:@"client_secret"];
    [dic setObject:grantType forKey:@"grant_type"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:redirectUri forKey:@"redirect_uri"];
    RequestAccessTokenResponse *response = [[RequestAccessTokenResponse alloc] init];
    NSOperation *operation = [self post:manager url:REQUEST_ACCESS_TOKEN params:dic response:response callback:callBack];
    return operation;
}

- (NSOperation *)requestPublicTimeLine:(AFHTTPRequestOperationManager *)manager accessToken:(NSString *)accessToken callBack:(SDK_CALLBACK)callBack;
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:accessToken forKey:@"access_token"];
    FirstPublic_TimelineResponse *response = [[FirstPublic_TimelineResponse alloc] init];
    NSOperation *operation = [self get:manager url:REQUEST_PUBLIC_TIMELINE params:dic response:response callback:callBack];
    return operation;
}

@end
