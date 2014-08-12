//
//  ContentView.m
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ContentView.h"

@interface ContentView()
{
    GlobalDataManager* dataCenter;
    EGORefreshTableHeaderView * refreshView;
    BOOL _isLoading;
    BOOL isLoadMore;
}
@end


@implementation ContentView
@synthesize dataArray;
@synthesize tableView;
-(void)dataInit
{
    dataArray=[[NSMutableArray alloc] init];
    dataCenter=[GlobalDataManager sharedDataManager];
}
-(void)viewInit
{

    tableView=[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self addSubview:tableView];
    
    refreshView=[[EGORefreshTableHeaderView alloc] initWithFrame:tableView.frame];
    refreshView.delegate=self;
    [self insertSubview:refreshView belowSubview:tableView];
    [refreshView release];
    
    
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self dataInit];
        [self viewInit];
        
        [self egoRefreshTableHeaderDidTriggerRefresh:refreshView];
    }
    return self;
}
-(void)dealloc
{
    [tableView release];
    [dataArray release];
    [super dealloc];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* tmpDict=[dataArray objectAtIndex:indexPath.row];
    ActivityCell* cell=(ActivityCell*)[tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:self options:nil] lastObject];
    }
    [cell.activityImageView setImageWithURL:[NSURL URLWithString:@"http://10.0.0.108/image/test1.png"] placeholderImage:[UIImage imageNamed:@"member.png"]];
    cell.activityTitleLabel.text=[tmpDict objectForKey:@"acttitle"];
    //cell.activityTimeLabel
    return cell;
}
-(void)fetchData
{
    //URL
    NSURL* url=[NSURL URLWithString:@"http://10.0.0.108:8080/ihd-app//active/queryActListOnPage"];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    //[dict setObject:areaID forKey:@"areaId"];
    //请求
    [WBHTTPRequest sendRequestWithURL:url parameterDict:dict type:kWBHTTPRequestGETType  queue:[dataCenter globalTaskQueue] completeHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"error:%@",connectionError);
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //失败
        if(connectionError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"连接错误:%@",connectionError);
                [self doneLoadingTableViewData];
                return ;
            });
            NSLog(@"xx");
        }
        NSError* error=nil;
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict:%@",dict);
        
        if(!error)
        {
            //加载更多
            if(isLoadMore)
            {
                
            }
            //重新刷新
            else
            {
                [dataArray removeAllObjects];
            }
            [dataArray addObjectsFromArray:[dict objectForKey:@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self doneLoadingTableViewData];
            });
        }
    }];
}
-(void)footerClicked:(UIButton*)btn
{
    isLoadMore=YES;
    [self fetchData];
}
- (void)reloadTableViewDataSource{
	_isLoading = YES;
    
    //加载数据。。。
    [self  fetchData];
   // [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_isLoading = NO;
    [tableView reloadData];
	[refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [refreshView egoRefreshScrollViewWillBeginScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[refreshView egoRefreshScrollViewDidScroll:scrollView];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	isLoadMore=NO;
	[self reloadTableViewDataSource];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _isLoading; // should return if data source model is
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
