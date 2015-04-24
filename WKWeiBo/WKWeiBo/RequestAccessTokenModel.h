//
//  RequestAccessTokenModel.h
//  WKWeiBo
//
//  Created by apple on 15/4/21.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestAccessTokenModel : NSObject<NSCoding>
@property (strong,nonatomic) NSString *access_token;//用于调用access_token，接口获取授权后的access token。
@property (strong,nonatomic) NSString *expires_in;//access_token的生命周期，单位是秒数。
@property (strong,nonatomic) NSString *remind_in;//access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
@property (strong,nonatomic) NSString *uid;//当前授权用户的UID。
-(instancetype)initWithDic:(NSDictionary*)dic;
+(RequestAccessTokenModel *)fromDic:(NSDictionary*)dic;
@end
