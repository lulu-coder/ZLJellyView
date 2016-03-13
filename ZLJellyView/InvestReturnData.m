//
//  InvestReturnData.m
//  ZLJellyView
//
//  Created by 张璐 on 16/01/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "InvestReturnData.h"
#import "InvestListData.h"

@implementation InvestReturnData

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [InvestListData class]};
}

@end
