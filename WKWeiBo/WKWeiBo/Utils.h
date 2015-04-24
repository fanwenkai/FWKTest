//
//  Utils.h
//  WKWeiBo
//
//  Created by apple on 15/4/20.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#ifndef WKWeiBo_Utils_h
#define WKWeiBo_Utils_h

//API接口连接

static  NSString * HOST_NAME = @"https://api.weibo.com";
//回调地址连接
static  NSString * REDIRECT_URL = @"https://api.weibo.com/oauth2/default.html";
//获取AccessToken连接
static  NSString * REQUEST_ACCESS_TOKEN = @"/oauth2/access_token";

static NSString * REQUEST_PUBLIC_TIMELINE = @"/2/statuses/public_timeline.json";

#endif
