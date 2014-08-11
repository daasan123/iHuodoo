//
//  ClubVC.m
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ClubVC.h"

@interface ClubVC ()

@end

@implementation ClubVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        pageCount=4;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* titles=@[@"全部",@"运动",@"娱乐",@"户外",@"更多"];
    NSInteger width[]={64,64,64,64,64};
    NSMutableArray* itemArray=[[NSMutableArray alloc] initWithCapacity:titles.count];
    for(int i=0;i<titles.count;i++)
    {
        NSString* title=titles[i];
        [itemArray addObject:@{NOMALKEY: @"normal.png",
                               HEIGHTKEY:@"helight.png",
                               TITLEKEY:title,
                               TITLEWIDTH:[NSNumber numberWithFloat:width[i]]}];
    }
    [self setMenuItems:itemArray];
    [menu clickButtonAtIndex:0];
    
     [self setCycleScrollViewPageCount:pageCount];
    // Do any additional setup after loading the view.
}
//cycleScrollView datasource
-(NSUInteger)numberOfPages
{
    return pageCount;
}
-(UIView*)viewForCycleScrollViewAtIndex:(NSUInteger)index
{
    UITableView* tableView=[[UITableView alloc] initWithFrame:cycleScrollView.bounds style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.bounces=NO;
    return [tableView autorelease];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
