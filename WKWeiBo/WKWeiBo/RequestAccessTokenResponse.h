//
//  RequestAccessTokenResponse.h
//  WKWeiBo
//
//  Created by apple on 15/4/21.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "GKResponse.h"
#import "RequestAccessTokenModel.h"

@interface RequestAccessTokenResponse : GKResponse
@property (strong,nonatomic) RequestAccessTokenModel *accessTokenMD;
- (BOOL)fromDic:(NSDictionary *)dic;
@end
