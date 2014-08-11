//
//  RootVC.m
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()

@end

@implementation RootVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviBack.png"] forBarMetrics:UIBarMetricsDefault];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
