//
//  ActivityVC.m
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ActivityVC.h"

@interface ActivityVC ()
{
    
}
@end

@implementation ActivityVC

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
    [super dataInit];
    //data init hear
    pageCount=5;
    
    NSArray* titleArray=@[@"全部活动",@"运动健身",@"户外郊游",@"休闲娱乐",@"聚餐",@"兴趣交友",@"结伴旅游",@"商务聚会",@"其他活动",@"更多活动"];
    NSArray* imageArray=@[@"activity_all.png",@"activity_sport.png",@"activity_meal.png",@"activity_all.png",@"activity_sport.png",@"activity_meal.png",@"activity_all.png",@"activity_sport.png",@"activity_meal.png",@"activity_meal.png"];
    for(int i=0;i<titleArray.count;i++)
    {
        [moreItemsArray addObject:@{@"title":titleArray[i],@"image":imageArray[i]}];
    }
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
-(void)tapped:(UITapGestureRecognizer*)tap
{
    NSLog(@"tap");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]
                                 initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    
    NSArray* titles=@[@"全部",@"今天",@"近三天",@"本周",@"本月",@"更多"];
    NSInteger width[]={48,48,80,48,48,48};
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
    [itemArray release];
    
    //[self setCycleScrollViewPageCount:pageCount];
    //xib
//    [cycleScrollView setCacheCount:pageCount];
//    cycleScrollView.datasource=self;
    
     NSInteger tableCount=titles.count-1;
    
    containerView=[[ContainerScrollView alloc] initWithFrame:CGRectMake(0, 64+MENU_HEIGHT, 320, self.view.bounds.size.height-64-MENU_HEIGHT-50)];
    containerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:containerView];
    containerView.containerDelegate=self;
    containerView.pagingEnabled=YES;
    containerView.contentSize=CGSizeMake(320*tableCount, containerView.bounds.size.height);
    
   
    for(int i=0;i<tableCount;i++)
    {
        //header
        UILabel* header=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 24)];
        header.backgroundColor=[UIColor groupTableViewBackgroundColor];
        header.text=@"附近的活动";
        
//        UILabel* footer=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
//        footer.backgroundColor=[UIColor groupTableViewBackgroundColor];
//        footer.textAlignment=NSTextAlignmentCenter;
//        footer.text=@"加载更多";
        
        
        
        ContentView* contentView=[[ContentView alloc] initWithFrame:CGRectMake(i*320, 0, containerView.bounds.size.width, containerView.bounds.size.height)];
        contentView.tag=i+1;
        //contentView.layer.borderColor=[UIColor redColor].CGColor;
        //contentView.layer.borderWidth=2;
        [contentView.tableView setTableHeaderView:header];
        
        
        //footer
        UIButton* footBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [footBtn setTitle:@"加载更多" forState:UIControlStateNormal];
        footBtn.frame=CGRectMake(0, 0, 0, 40);
        [footBtn addTarget:contentView action:@selector(footerClicked:) forControlEvents:UIControlEventTouchUpInside];
        [contentView.tableView setTableFooterView:footBtn];
        
        
        [containerView addSubview:contentView];
        [containerView.viewArray addObject:contentView];
    }
}
//menu 代理
-(void)horizonalMenuDidClickedButtonAtIndex:(NSInteger)aIndex
{
    if(aIndex==5)
    {
        [WBCombList showInRect:CGRectMake(320-80, 94, 80, containerView.bounds.size.height) edgeInset:UIEdgeInsetsMake(3, 3, 3, 3) delegate:self inView:self.view withTag:1];
    }
    else
    {
        [containerView scrollToIndex:aIndex];
    }
}
//容器代理
-(void)containerScrollView:(ContainerScrollView *)aScrollView currentIndex:(NSInteger)aIndex
{
    [menu clickButtonAtIndex:aIndex];
}
//更多下拉框代理
-(void)combList:(WBCombList *)aCombList SelectedIndexPath:(NSIndexPath *)aIndexPath
{
    NSLog(@"selected index:%d",aIndexPath.row);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moreItemsArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* tmpDict=[moreItemsArray objectAtIndex:indexPath.row];
    ActivityMoreCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ActivityMoreCell"];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ActivityMoreCell" owner:self options:nil] lastObject];
    }
    cell.typeImageView.image=[UIImage imageNamed:[tmpDict objectForKey:@"image"]];
    cell.titleLabel.text=[tmpDict objectForKey:@"title"];
    return cell;
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
    //tableView.bounces=NO;
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
