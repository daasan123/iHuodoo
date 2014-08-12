//
//  ContainerScrollView.m
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ContainerScrollView.h"

@implementation ContainerScrollView
@synthesize viewArray;
@synthesize containerDelegate;
-(void)dataInit
{
    viewArray=[[NSMutableArray alloc] initWithCapacity:0];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self dataInit];
        self.delegate=self;
        self.showsHorizontalScrollIndicator=NO;
        
    }
    return self;
}
-(void)dealloc
{
    [viewArray release];
    [super dealloc];
}
-(void)scrollToIndex:(NSInteger)aIndex
{
    [self scrollRectToVisible:CGRectMake(self.bounds.size.width*aIndex, 0, self.bounds.size.width, self.bounds.size.height) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset= scrollView.contentOffset;
    NSInteger index= offset.x/self.bounds.size.width;
    NSLog(@"index:%d",index);
    if([containerDelegate respondsToSelector:@selector(containerScrollView:currentIndex:)])
    {
        [containerDelegate containerScrollView:self currentIndex:index];
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
