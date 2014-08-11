//
//  WBCycleScrollView.h
//  WBCycleScorllView
//
//  Created by 伍 兵 on 14-2-25.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PRINT_VIEW_TAG 0
#define DEFAULT_CACHE_COUNT 5
@class WBCycleScrollView;
@protocol WBCycleScrollViewDatasource <NSObject>
@required
-(NSUInteger)numberOfPages;
-(UIView*)viewForCycleScrollViewAtIndex:(NSUInteger)index;
-(void)cycleScrollView:(WBCycleScrollView*)aCycleView currentIndex:(NSInteger)aIndex;
@end



@interface WBCycleScrollView : UIView<UIScrollViewDelegate>
{
    id<WBCycleScrollViewDatasource>datasource;
}

@property(nonatomic,assign) id<WBCycleScrollViewDatasource>datasource;
-(void)setCacheCount:(NSInteger)aCount;
-(void)setCycleViewFrame:(CGRect)aFrame;
- (id)initWithFrame:(CGRect)frame withCacheCount:(NSUInteger)aCacheCount;
@end
