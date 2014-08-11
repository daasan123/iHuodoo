//
//  WBCycleScrollView.m
//  WBCycleScorllView
//
//  Created by 伍 兵 on 14-2-25.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "WBCycleScrollView.h"


@interface WBCycleScrollView()
{
    NSUInteger width;
    NSUInteger height;
    NSUInteger cacheCount;
    NSUInteger totalCount;
    
    NSMutableArray* cacheArray;
    
    NSInteger currentPage;
    
    UIScrollView* contentScrollView;
    UIPageControl* pageControl;

}

@end

@implementation WBCycleScrollView
@synthesize datasource;
-(void)setCacheCount:(NSInteger)aCount
{
    cacheCount=aCount;
    
    contentScrollView.contentSize=CGSizeMake(width*cacheCount, height);
    contentScrollView.contentOffset=CGPointMake((cacheCount-1)/2*width, 0);
}
-(void)setCycleViewFrame:(CGRect)aFrame
{
    self.frame=aFrame;
    width=self.frame.size.width;
    height=self.frame.size.height;
    contentScrollView.frame=CGRectMake(0, 0, width, height);
    contentScrollView.contentSize=CGSizeMake(width*cacheCount, height);
    contentScrollView.contentOffset=CGPointMake((cacheCount-1)/2*width, 0);
    pageControl.frame=CGRectMake(0, height-80, width, 20);
    [self setNeedsLayout];
}
-(void)setDatasource:(id<WBCycleScrollViewDatasource>)aDatasource
{
    datasource=aDatasource;
    [self reloadData];
}

-(void)dataInitWithCacheCount:(NSInteger)aCacheCount
{
    self.backgroundColor=[UIColor yellowColor];
    //self.layer.borderWidth=2;
    //self.layer.borderColor=[UIColor blueColor].CGColor;
    self.clipsToBounds=NO;
    
    
    width=self.frame.size.width;
    height=self.frame.size.height;
    
    NSLog(@"height:%d",height);
    cacheCount=aCacheCount;
    currentPage=0;
    cacheArray=[[NSMutableArray alloc] initWithCapacity:cacheCount];
    
    //内容视图
    contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    contentScrollView.contentSize=CGSizeMake(width*cacheCount, height);
    contentScrollView.contentOffset=CGPointMake((cacheCount-1)/2*width, 0);
    
    contentScrollView.bounces=NO;
    contentScrollView.delegate=self;
    contentScrollView.pagingEnabled=YES;
    contentScrollView.backgroundColor=[UIColor cyanColor];
    contentScrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:contentScrollView];
    
    //页码标
    pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, height-80, width, 20)];
    pageControl.userInteractionEnabled=NO;
    pageControl.hidesForSinglePage=YES;
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    [self addSubview:pageControl];
}
- (id)initWithFrame:(CGRect)frame withCacheCount:(NSUInteger)aCacheCount
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self dataInitWithCacheCount:aCacheCount];
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        NSLog(@"frame:%@",NSStringFromCGRect(self.frame));
        [self dataInitWithCacheCount:DEFAULT_CACHE_COUNT];
    }
    return self;
}
-(void)dealloc
{
    [pageControl release];
    [contentScrollView release];
    [super dealloc];
}
-(void)printViewTag
{
#if PRINT_VIEW_TAG
    for(UIView* view in cacheArray)
    {
        NSLog(@"tag:%d",view.tag);
    }
    NSLog(@"---------------------");
#endif
}
-(void)reloadData
{
    totalCount= [datasource numberOfPages];
    pageControl.numberOfPages=totalCount;
    
    for(NSInteger i=0;i<cacheCount;i++)
    {
        NSInteger x=i-(cacheCount-1)/2;
        x=x<0?-(abs(x)%totalCount):x;
        NSInteger index=(x+totalCount)%totalCount;
        UIView* view=[datasource viewForCycleScrollViewAtIndex:index];
        [cacheArray addObject:view];
        //NSLog(@"i:%d,x:%d",i,x);
    }
    [self setNeedsLayout];
    [self printViewTag];
}
-(void)layoutSubviews
{
    NSUInteger mid=(cacheArray.count-1)/2;
    //最先添加可见的视图
    UIView* midView=[cacheArray objectAtIndex:mid];
    midView.frame=CGRectMake(mid*width, 0, width, height);
    [contentScrollView addSubview:midView];
    //随后添加其他的视图
    for(int i=0;i<cacheArray.count;i++)
    {
        if(i==mid)
            continue;
        UIView * view=[cacheArray objectAtIndex:i];
        view.frame=CGRectMake(i*width, 0, width, height);
        [contentScrollView addSubview:view];
    }
}
-(void)cacheViewWithIsUp:(BOOL)isUp
{
    NSInteger willCachePage;
    if(isUp)
    {
        willCachePage=(currentPage+(cacheCount-1)/2)%totalCount;
        [cacheArray removeObjectAtIndex:0];
        [cacheArray addObject:[datasource viewForCycleScrollViewAtIndex:willCachePage]];
    }
    else
    {
        NSInteger x=currentPage-(cacheCount-1)/2;
        x=x<0?-(abs(x)%totalCount):x;
        willCachePage=(x+totalCount)%totalCount;
        [cacheArray removeLastObject];
        [cacheArray insertObject:[datasource viewForCycleScrollViewAtIndex:willCachePage] atIndex:0];
    }
    [self printViewTag];
}
#pragma scrollView delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    scrollView.scrollEnabled=NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //判断
    BOOL isUp=NO;
    NSUInteger v=(cacheCount-1)/2;
    if(scrollView.contentOffset.x==((v-1)*width))
    {
        //NSLog(@"left");
        currentPage--;
        isUp=NO;
        if(currentPage<0)
            currentPage=totalCount-1;
    }
    else if(scrollView.contentOffset.x==(v+1)*width)
    {
        //NSLog(@"right");
        currentPage++;
        isUp=YES;
        if(currentPage>totalCount-1)
            currentPage=0;
    }
    else
    {
        scrollView.scrollEnabled=YES;
        //NSLog(@"no turn page");
        return;
    }
    //界面更改
    pageControl.currentPage=currentPage;
    contentScrollView.contentOffset=CGPointMake(v*width, 0);
    [self setNeedsLayout];
    //加载
    [self cacheViewWithIsUp:isUp];
    scrollView.scrollEnabled=YES;
    
    if([datasource respondsToSelector:@selector(cycleScrollView:currentIndex:)])
    {
        [datasource cycleScrollView:self currentIndex:currentPage];
    }
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
