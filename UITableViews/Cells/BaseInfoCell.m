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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /// 设置frame 方法一
//        self.timeLab.frame   = CGRectMake(10, 20, 60, 40);
//        self.tlineLab.frame  = CGRectMake(self.timeLab.right+15, 0, .5, 20);
//        self.typeImageV.frame = CGRectMake(self.tlineLab.centerX-15, self.tlineLab.bottom, 30, 30);
//        self.blineLab.frame  = CGRectMake(self.tlineLab.centerX, self.typeImageV.bottom, .5, 30);
        
        /// 设置约束 方法二 （Masonry）
        [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView).with.offset(15);
            make.left.equalTo(self.contentView).with.offset(10);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(60);
            
            /* 等价于
             make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
             */
            /* 也等价于
             make.top.left.bottom.and.right.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
             */
        }];
        
        [self.tlineLab mas_remakeConstraints:^(MASConstraintMaker *make) {
          
            make.top.equalTo(self.contentView).with.offset(0);
            make.left.equalTo(self.timeLab.mas_right).with.offset(10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(.5);
            
        }];
        
        [self.typeImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.tlineLab.mas_bottom).with.offset(0);
            make.centerX.mas_equalTo(self.tlineLab.mas_centerX);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            
            
        }];
        
        [self.blineLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        
            make.top.equalTo(self.typeImageV.mas_bottom).with.offset(0);
            make.left.equalTo(self.timeLab.mas_right).with.offset(10);
            make.bottom.equalTo(self.contentView).with.offset(0);
            make.width.mas_equalTo(.5);
        
        }];
        
        
    }
    return self;
}

#pragma mark Set
- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc ]init];
        _timeLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLab];
    }
    return _timeLab;
}
- (UIImageView *)typeImageV
{
    if (!_typeImageV) {
        _typeImageV = [[UIImageView alloc]init];
        _typeImageV.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_typeImageV];
    }
    return _typeImageV;
}
-(UILabel *)tlineLab{
    if (!_tlineLab) {
        _tlineLab = [UILabel new];
        _tlineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_tlineLab];
    }
    return _tlineLab;
}
-(UILabel *)blineLab{
    if (!_blineLab) {
        _blineLab = [UILabel new];
        _blineLab.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_blineLab];
    }
    return _blineLab;
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
    NSLog(@"model.identifyUrl is %@",model.identifyUrl);
    NSLog(@"model.identifyUrl is %@",model.time);
    self.typeImageV.image = [UIImage imageNamed:@""];
    self.timeLab.text = model.time;

}
@end
