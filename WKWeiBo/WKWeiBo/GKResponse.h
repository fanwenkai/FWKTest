//
//  GKResponse.h
//  WKWeiBo
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RET_SUCCESSED 0 //请求成功
#define RET_DATA_FORMAT_ERROR 1 // 服务器返回数据格式错误
#define RET_HTTP_ERROR 2 // http请求错误
@interface GKResponse : NSObject
@property (assign, nonatomic) NSInteger ret;
@property (copy, nonatomic) NSString *msg;
- (BOOL)fromDic:(NSDictionary *)dic;
@end
