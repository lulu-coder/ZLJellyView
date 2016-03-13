//
//  ViewController.m
//  ZLJellyView
//
//  Created by 张璐 on 16/1/20.
//  Copyright © 2016年 张璐. All rights reserved.
//

#import "ViewController.h"
#import "ZLJellyView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZLJellyView * jellyView = [[ZLJellyView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:jellyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
