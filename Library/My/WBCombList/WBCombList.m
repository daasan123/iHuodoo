//
//  WBCombList.m
//  WBCombList
//
//  Created by 伍 兵 on 14-7-25.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "WBCombList.h"



@interface CombContentView : UIView
@property(nonatomic,assign) BOOL isTouchIn;
@end
@implementation CombContentView
@synthesize isTouchIn;
@end

@interface CombContentListView : UITableView
@property(nonatomic,assign) BOOL isTouchIn;
@end
@implementation CombContentListView
@synthesize isTouchIn;
@end



@interface WBCombList()
{
   
}
@end


@implementation WBCombList
@synthesize delegate;
@synthesize contentListView;
@synthesize  contentView;


+(WBCombList*)showInRect:(CGRect)aRect edgeInset:(UIEdgeInsets)aEdgeInset delegate:(id<UITableViewDataSource,UITableViewDelegate>)aDelegate inView:(UIView*)aView withTag:(NSInteger)aTag
{
    WBCombList* combList=[[WBCombList alloc] initWithFrame:aRect edgeInset:aEdgeInset delegate:aDelegate];
    combList.tag=aTag;
    [combList showAtRect:aRect edgeInset:aEdgeInset inView:aView ];
    [UIView animateWithDuration:.5 animations:^{
        combList.backgroundColor=COMB_MASK_COLOR;
    }];
    combList.contentView.backgroundColor=COMB_CONTENT_BACK_COLOR;
    combList.contentListView.backgroundColor=COMB_CONTENT_LIST_BACK_COLOR;
    [combList release];
    return combList;
}


- (id)initWithFrame:(CGRect)frame edgeInset:(UIEdgeInsets)aEdgeInset delegate:(id<UITableViewDataSource,UITableViewDelegate,WBCombListDelegate>)aDelegate
{
    self = [super initWithFrame:frame];
    if (self) {

        // Initialization code
        contentView=[[CombContentView alloc] initWithFrame:CGRectZero];
        contentView.backgroundColor=[UIColor redColor];
        self.delegate=aDelegate;
        
        CGRect listRect= UIEdgeInsetsInsetRect(self.bounds, aEdgeInset);
        contentListView=[[CombContentListView alloc] initWithFrame:listRect];
        contentListView.delegate=aDelegate;
        contentListView.dataSource=aDelegate;
        contentListView.bounces=NO;
        [contentView addSubview:contentListView];
        
        [self addSubview:contentView];
        
        [self viewInit];
    }
    return self;
}
-(void)viewInit
{
  
}
-(void)showAtRect:(CGRect)aRect edgeInset:(UIEdgeInsets)edgeInset inView:(UIView*)aView
{
    NSLog(@"row.height:%f",contentListView.rowHeight);
    self.frame=aView.bounds;
    CGRect needRect=CGRectMake(aRect.origin.x, aRect.origin.y, aRect.size.width, MIN(aRect.size.height,edgeInset.top+edgeInset.bottom+[contentListView numberOfRowsInSection:0]* [contentListView.delegate tableView:contentListView heightForRowAtIndexPath:nil]));
    
    contentView.frame=needRect;
    contentListView.frame =UIEdgeInsetsInsetRect(contentView.bounds, edgeInset);
    [aView addSubview:self];
    [aView bringSubviewToFront:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
    [tap release];
    
}
-(void)tapped:(UITapGestureRecognizer*)tapGuesture
{
   
    CGPoint point = [tapGuesture locationInView:self.superview];
    if(CGRectContainsPoint(contentView.frame, point))
    {
        for(NSIndexPath * path in [contentListView indexPathsForVisibleRows])
        {
           CGRect cellRect= [contentListView rectForRowAtIndexPath:path];
            point =[tapGuesture locationInView:contentListView];
            if(CGRectContainsPoint(cellRect, point))
            {
                [contentListView selectRowAtIndexPath:path animated:ANIMATE_SELECT scrollPosition:UITableViewScrollPositionMiddle];
                if([delegate respondsToSelector:@selector(combList:SelectedIndexPath:)])
                {
                    [delegate combList:self SelectedIndexPath:path];
                    
                }
            }
        }
        
    }
    else
    {
        NSLog(@"out");
        [self removeFromSuperview];
    }
    
}
-(void)dealloc
{
    [contentListView release];
    [contentView release];
    [super dealloc];
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
