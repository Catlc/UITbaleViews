//
//  BaseInfoCell.m
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "BaseInfoCell.h"

@implementation BaseInfoCell

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
    return 90;
}
/// 根据数据模型来显示内容
- (void)showInfo:(InfoModel *)model
{
    
}
@end
