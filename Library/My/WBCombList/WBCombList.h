//
//  WBCombList.h
//  WBCombList
//
//  Created by 伍 兵 on 14-7-25.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WBCombListHeader.h"


#define   ANIMATE_SELECT 0
#define  COMB_MASK_COLOR [UIColor colorWithWhite:0.4 alpha:0.4];
#define  COMB_CONTENT_BACK_COLOR [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.8]
#define  COMB_CONTENT_LIST_BACK_COLOR [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.8]


@class CombContentListView;
@class CombContentView;
@class WBCombList;

@protocol WBCombListDelegate<NSObject>
-(void)combList:(WBCombList*)aCombList SelectedIndexPath:(NSIndexPath*)aIndexPath;
@end



@interface WBCombList : UIView
{
    CombContentListView* contentListView;
    CombContentView* contentView;
    id<WBCombListDelegate> delegate;
   
}
@property(nonatomic,assign) id<WBCombListDelegate> delegate;
@property(nonatomic,retain) CombContentListView *contentListView;
@property(nonatomic,retain) CombContentView *contentView;


+(WBCombList*)showInRect:(CGRect)aRect edgeInset:(UIEdgeInsets)aEdgeInset delegate:(id<UITableViewDataSource,UITableViewDelegate>)aDelegate inView:(UIView*)aView withTag:(NSInteger)aTag;

- (id)initWithFrame:(CGRect)frame edgeInset:(UIEdgeInsets)aEdgeInset delegate:(id<UITableViewDataSource,UITableViewDelegate>)aDelegate;
@end
