//
//  InvestReturnData.h
//  ZLJellyView
//
//  Created by 张璐 on 16/01/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InvestListData;

@interface InvestReturnData : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) NSArray<InvestListData *> *data;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, strong) NSArray *advertdata;

@property (nonatomic, copy) NSString *action;

@property (nonatomic, assign) NSInteger pagetotal;

@end