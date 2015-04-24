//
//  FirstPublic_TimelineModel.h
//  WKWeiBo
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstPublic_TimelineModel : NSObject
@property(strong,nonatomic) NSString *created_at;//微博创建时间
@property(strong,nonatomic) NSString *idstr;//字符串型的微博ID
@property(strong,nonatomic) NSString *source;//微博来源
@property(strong,nonatomic) NSString *text;//微博信息内容
@property(assign,nonatomic) int reposts_count;//转发数
@property(assign,nonatomic) int comments_count;//评论数
@property(assign,nonatomic) int attitudes_count;//表态数
//@property(strong,nonatomic) NSMutableArray *pic_urls;//微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
@property(strong,nonatomic) NSString *thumbnail_pic;//缩略图片地址，没有时不返回此字段

//微博作者的用户信息字段
@property(strong,nonatomic) NSString *user_idstr;//字符串型的用户UID
@property(strong,nonatomic) NSString *user_screen_name;//用户昵称
@property(strong,nonatomic) NSString *user_description;//用户个人描述
@property(strong,nonatomic) NSString *user_profile_image_url;//用户头像地址（中图），50×50像素
@property(strong,nonatomic) NSString *user_profile_url;//用户的微博统一URL地址"profile_url":"u/5528823625"
@property(assign,nonatomic) int user_followers_count;//粉丝数
@property(assign,nonatomic) int user_friends_count;//关注数
@property(assign,nonatomic) int user_favourites_count;//收藏数
@property(assign,nonatomic) int user_statuses_count;//微博数
@property(strong,nonatomic) NSString *user_created_at;//用户创建（注册）时间

-(instancetype)initWithDic:(NSDictionary*)dic;
+(FirstPublic_TimelineModel *)fromDic:(NSDictionary*)dic;

@end
