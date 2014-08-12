//
//  ActivityCell.h
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-12.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
{
  
}
@property(nonatomic,retain)IBOutlet UIImageView* activityImageView;
@property(nonatomic,retain)IBOutlet UILabel* activityTitleLabel;
@property(nonatomic,retain)IBOutlet UILabel* activityTimeLabel;
@property(nonatomic,retain)IBOutlet UILabel* activityAddressLabel;
@end
