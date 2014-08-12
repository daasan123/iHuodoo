//
//  ActivityClubBaseVC.m
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ActivityClubBaseVC.h"

@interface ActivityClubBaseVC ()
{
   
}
@end

@implementation ActivityClubBaseVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dataInit
{
    [super  dataInit];
    moreItemsArray=[[NSMutableArray alloc] initWithCapacity:10];
    //data init hear
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        [self dataInit];
    }
    return self;
}
-(void)setCycleScrollViewPageCount:(NSInteger)aCount
{
    if(cycleScrollView)
        return;
    //循环滑动
    cycleScrollView=[[WBCycleScrollView alloc] initWithFrame:CGRectMake(0, 64+MENU_HEIGHT, 320, 454-MENU_HEIGHT) withCacheCount:aCount];
    cycleScrollView.datasource=self;
    [self.view addSubview:cycleScrollView];
}
-(void)setMenuItems:(NSArray*)aArray
{
    if(menu)
        return;
    menu=[[MenuHrizontal alloc] initWithFrame:CGRectMake(0, 64, 320, 30) ButtonItems:aArray];
    menu.delegate=self;
    [self.view addSubview:menu];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviBack.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView=[[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)] autorelease];
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [moreItemsArray release];
    [super dealloc];
}
#pragma mark - WBCycleScrollView datasource
-(NSUInteger)numberOfPages
{
    return pageCount;
}
-(UIView*)viewForCycleScrollViewAtIndex:(NSUInteger)index
{
    UITableView* tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    return [tableView autorelease];
}
-(void)cycleScrollView:(WBCycleScrollView *)aCycleView currentIndex:(NSInteger)aIndex
{
    NSLog(@"index:%d",aIndex);
    [menu clickButtonAtIndex:aIndex];
}
#pragma mark - UITableView  
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"]autorelease];
    }
    cell.textLabel.text=@"cell";
    return cell;
}
#pragma mark - menu 代理
-(void)horizonalMenuDidClickedButtonAtIndex:(NSInteger)aIndex
{
    NSLog(@"menuIndex:%d",aIndex);
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
