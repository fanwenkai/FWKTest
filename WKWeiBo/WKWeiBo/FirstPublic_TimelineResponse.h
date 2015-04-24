//
//  FirstPublic_TimelineResponse.h
//  WKWeiBo
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 wenkai. All rights reserved.
//

#import "GKResponse.h"
#import "FirstPublic_TimelineModel.h"
@interface FirstPublic_TimelineResponse : GKResponse
@property(strong,nonatomic) FirstPublic_TimelineModel *publicData;
@property(strong,nonatomic) NSMutableArray *arrayData;
- (BOOL)fromDic:(NSDictionary *)dic;
@end
