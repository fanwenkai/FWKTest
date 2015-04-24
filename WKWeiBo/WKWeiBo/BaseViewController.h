//
//  BaseViewController.h
//  WKWeiBo
//
//  Created by apple on 15/4/21.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
#pragma mark - 登录
- (void)login;
#pragma mark - 获取Token
- (NSString *)getToken;
@end
