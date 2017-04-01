//
//  BaseInfoCell.h
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//


#define  iWidthOfCell   120


#import <UIKit/UIKit.h>
#import "InfoModel.h"

@protocol BaseInfoCellDelegate <NSObject>

- (void)didClickImageAtIndex:(NSInteger)index withAssets:(NSArray *)assets;

- (void)didClickVideoWithUrl:(NSString *)videoUrl;


@end

@interface BaseInfoCell : UITableViewCell

///UI
@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,strong)UIImageView *typeImageV;

@property(nonatomic,strong)UILabel *tlineLab;

@property(nonatomic,strong)UILabel *blineLab;


/// BaseInfoCellDelegate
@property (weak, nonatomic) id <BaseInfoCellDelegate> delegate;

/// 返回Cell高度
+ (CGFloat)returnCellHeight:(InfoModel *)comment;
/// 根据数据模型来显示内容
- (void)showInfo:(InfoModel *)model;

@end
