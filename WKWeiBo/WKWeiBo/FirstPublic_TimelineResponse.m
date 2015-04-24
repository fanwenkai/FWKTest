//
//  FirstPublic_TimelineResponse.m
//  WKWeiBo
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "FirstPublic_TimelineResponse.h"

@implementation FirstPublic_TimelineResponse
- (BOOL)fromDic:(NSDictionary *)dic
{
    if ([super fromDic:dic])
    {
        if (dic)
        {
            NSArray *data = dic[@"statuses"];
            if (data)
            {
                self.arrayData = [[NSMutableArray alloc] init];
                for (NSDictionary *temp in data)
                {
                    FirstPublic_TimelineModel *msg = [FirstPublic_TimelineModel fromDic:temp];
                    NSLog(@"------%@-----------",msg);
                    [self.arrayData addObject:msg];
                }
            }
            return true;
        }
    }
    return NO;
}
@end
