//
//  GKResponse.m
//  WKWeiBo
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "GKResponse.h"

@implementation GKResponse
- (BOOL)fromDic:(NSDictionary *)dic
{
    if(dic == nil || ![dic isKindOfClass:[NSDictionary class]])
    {
        self.ret = RET_DATA_FORMAT_ERROR;//服务器返回数据格式错误
        self.msg = @"服务器返回数据格式错误";
    }
    return self.ret == 0 ? YES : NO;
}
@end
