//
//  FirstTVC01.m
//  WKWeiBo
//
//  Created by apple on 15/4/22.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//
/*Cell的属性
 @property(strong,nonatomic) UIImageView *userPic;//用户头像
 @property(strong,nonatomic) UILabel *userName;//用户昵称
 @property(strong,nonatomic) UILabel *createTime;//微博创建时间
 @property(strong,nonatomic) UIWebView *sourceWeb;//微博来源
 @property(strong,nonatomic) UITextView *mainText;//微博正文
 @property(strong,nonatomic) UIWebView *imageWeb;//显示微博附带图片
 @property(strong,nonatomic) UIButton *repostsBtn;//转发数
 @property(strong,nonatomic) UIButton *commentsBtn;//评论数
 @property(strong,nonatomic) UIButton *attitudesBtn;//关注数
 */
#import "FirstTVC01.h"

#define USER_PIC_SIZE CGSizeMake(50, 50)
@interface FirstTVC01 ()

@end
@implementation FirstTVC01
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.webView.scrollView.scrollEnabled = NO;
    
}
#pragma mark - 转发按钮
- (IBAction)repostsBtnClicked:(id)sender
{
    
}
#pragma mark - 评论按钮
- (IBAction)commentsBtnClicked:(id)sender
{
    
}
#pragma mark - 赞按钮
- (IBAction)attitudesBtnClicked:(id)sender
{
    
}


@end
