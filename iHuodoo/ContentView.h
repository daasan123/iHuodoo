//
//  ContentView.h
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCell.h"
#import "EGORefreshTableHeaderView.h"
#import "UIImageView+WebCache.h"
@interface ContentView : UIView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    NSMutableArray* dataArray;
    UITableView* tableView;
}
@property(nonatomic,retain)NSMutableArray* dataArray;
@property(nonatomic,retain)UITableView* tableView;
@end
