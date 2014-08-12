//
//  ActivityClubBaseVC.h
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RootVC.h"
#import "MenuHrizontal.h"
#import "WBCycleScrollView.h"
#import "ContainerScrollView.h"
#import "WBCombList.h"
#define MENU_HEIGHT 30


@interface ActivityClubBaseVC : RootVC<WBCycleScrollViewDatasource,UITableViewDelegate,UITableViewDataSource,MenuHrizontalDelegate>
{
    NSInteger pageCount;
    
    IBOutlet WBCycleScrollView* cycleScrollView;
    IBOutlet MenuHrizontal * menu;
    
    ContainerScrollView* containerView;
    
    NSMutableArray* moreItemsArray;
}
-(void)setMenuItems:(NSArray*)aArray;
-(void)setCycleScrollViewPageCount:(NSInteger)aCount;
@end
