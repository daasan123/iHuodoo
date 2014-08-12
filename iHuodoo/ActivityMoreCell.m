//
//  ActivityMoreCell.m
//  iHuodoo
//
//  Created by 伍 兵 on 14-8-12.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ActivityMoreCell.h"

@implementation ActivityMoreCell
@synthesize titleLabel,typeImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
