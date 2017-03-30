//
//  WetherCell.m
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "WetherCell.h"

@implementation WetherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)returnCellHeight:(InfoModel *)comment
{
    return 200;
}
-(void)showInfo:(InfoModel *)model
{
    
    NSLog(@"WetherCell %@",model);


}


@end
