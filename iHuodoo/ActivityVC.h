//
//  ActivityVC.h
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-11.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ActivityClubBaseVC.h"
#import "ContentView.h"
#import "ActivityMoreCell.h"

@interface ActivityVC : ActivityClubBaseVC<ContainerScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,WBCombListDelegate>

@end
