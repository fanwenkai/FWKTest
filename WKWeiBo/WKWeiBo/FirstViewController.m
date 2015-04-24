//
//  FirstViewController.m
//  WKWeiBo
//
//  Created by apple on 15/4/21.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstPublic_TimelineResponse.h"
#import "FirstPublic_TimelineModel.h"
#import "FirstTVC01.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FirstViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示进度条
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //进行网络数据请求
    [[WONetwork getInstance] requestPublicTimeLine:[[WONetwork getInstance] woManager] accessToken:[self getToken] callBack:^(GKResponse *result) {
        if (result.ret == RET_SUCCESSED)
        {
            NSLog(@"请求数据成功");
            //数据请求成功
            FirstPublic_TimelineResponse *firstRes = (FirstPublic_TimelineResponse *)result;
            self.dataArray = [NSArray arrayWithArray:firstRes.arrayData];
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"请求数据失败");
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
//    [self.tableView registerClass:[FirstTVC01 class] forCellReuseIdentifier:@"FirstTVC01"];
}
#pragma mark - 生成HTML解析
- (NSString *)createHTML:(FirstPublic_TimelineModel *)model
{
    NSString *html = [NSString stringWithFormat:@" <!DOCTYPE html> \
                      <html> \
                      <body> \
                      <table border=\"0\"> \
                      <tr> \
                      <td  rowspan=\"2\"> \
                      <img src=\"%@\" alt=\"头像\"></td> \
                      <td><font size=\"1\">%@</font></td> \
                      </tr> \
                      <tr> \
                      <td><font size=\"0.5\">%@</font></td> \
                      <td><font size=\"0.5\">%@</font></td> \
                      </tr> \
                      <tr> \
                      <td colspan=\"3\"><font size=\"2\">%@</font> \
                      </td> \
                      </tr> \
                      </table> \
                      <img src=\"%@\"> \
                      </body> \
                      </html>",model.user_profile_image_url,model.user_screen_name,model.created_at,model.source,model.text,model.thumbnail_pic];
    return html;
}
#pragma mark - 初始化TableView
- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = view;
}
#pragma mark - 实现TableView的代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FirstTVC01";
    
    FirstTVC01 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[FirstTVC01 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    FirstPublic_TimelineModel *temp = self.dataArray[indexPath.row];
    NSLog(@"cell为真");
    [cell.webView loadHTMLString:[self createHTML:temp] baseURL:nil];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FirstTVC01 *cell = (FirstTVC01 *)[self.tableView cellForRowAtIndexPath:indexPath];
//    return [[cell.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue] + 40.0f;
//    [self.tableView cellForRowAtIndexPath:indexPath];
    return 450;
}
@end