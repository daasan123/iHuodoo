//
//  ContainerScrollView.h
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContainerScrollView;
@protocol ContainerScrollViewDelegate <NSObject>
-(void)containerScrollView:(ContainerScrollView*)aScrollView currentIndex:(NSInteger)aIndex;
@end


@interface ContainerScrollView : UIScrollView<UIScrollViewDelegate>
{
    NSMutableArray* viewArray;
    id<ContainerScrollViewDelegate>containerDelegate;
}
@property(nonatomic,retain) NSMutableArray* viewArray;
@property(nonatomic,retain) id<ContainerScrollViewDelegate>containerDelegate;
-(void)scrollToIndex:(NSInteger)aIndex;
@end
