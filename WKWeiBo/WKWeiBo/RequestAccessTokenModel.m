//
//  RequestAccessTokenModel.m
//  WKWeiBo
//
//  Created by apple on 15/4/21.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "RequestAccessTokenModel.h"

@implementation RequestAccessTokenModel
-(instancetype)initWithDic:(NSDictionary*)dic
{
    if ([super init])
    {
        self.access_token = dic[@"access_token"];
        self.expires_in = dic[@"expires_in"];
        self.remind_in = dic[@"remind_in"];
        self.uid = dic[@"uid"];
    }
    return self;
}
+(RequestAccessTokenModel *)fromDic:(NSDictionary*)dic
{
    if (dic==nil || ![dic isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    return [[RequestAccessTokenModel alloc] initWithDic:dic];
}
#pragma mark - 实现NSCoding协议
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ([super init])
    {
        //实现   解析
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
