//
//  BaseInfoCell.h
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"

@interface BaseInfoCell : UITableViewCell

/// 返回Cell高度
+ (CGFloat)returnCellHeight:(InfoModel *)comment;
/// 根据数据模型来显示内容
- (void)showInfo:(InfoModel *)model;

@end
