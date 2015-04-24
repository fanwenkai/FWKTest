//
//  RequestAccessTokenResponse.m
//  WKWeiBo
//
//  Created by apple on 15/4/21.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "RequestAccessTokenResponse.h"

@implementation RequestAccessTokenResponse
- (BOOL)fromDic:(NSDictionary *)dic
{
    if ([super fromDic:dic])
    {
        self.accessTokenMD = [RequestAccessTokenModel fromDic:dic];
        [self saveData];
        return YES;
    }
    return NO;
}
- (void)saveData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.accessTokenMD];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:ACCESS_TOKEN_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
