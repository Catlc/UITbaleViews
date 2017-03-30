//
//  SheepInfoCell.m
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "SheepInfoCell.h"

@implementation SheepInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIView *)baseView
{
    if (!_baseView) {
        _baseView = [UIView new];
        [self.contentView addSubview:_baseView];
    }
    return _baseView;
}

+ (CGFloat)returnCellHeight:(InfoModel *)comment
{
    return comment.infoArray.count *40;
}

-(void)showInfo:(InfoModel *)model
{
    
    for (UILabel *view in _baseView.subviews) {
        [view removeFromSuperview];
    }
    self.baseView.frame = CGRectMake(0, 0, kWidthOfScreen, model.infoArray.count *40);

    
    //    NSLog(@"WetherCell %@",model);
    for (int i = 0; i<model.infoArray.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(75, i*40, kWidthOfScreen, 40)];
        lab.text = model.infoArray[i];
        [_baseView addSubview:lab];
    }

    
    
}

@end
