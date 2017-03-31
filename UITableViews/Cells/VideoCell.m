//
//  VideoCell.m
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell()

@property(nonatomic,copy)NSString *videoUrl;

@end

@implementation VideoCell

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
    return 180;
}
-(void)showInfo:(InfoModel *)model
{
    _videoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:model.infoArray[0]]];
    _videoImage.userInteractionEnabled = YES;
    [_videoImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideo:)]];
    _videoUrl = @"www.baidu.com"; //model.identifyUrl;
    _videoImage.frame = CGRectMake(75, 0, kWidthOfScreen - 75-20, 180);
    [self.contentView addSubview:_videoImage];
    
}
-(void)playVideo:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(didClickVideoWithUrl:)]) {
        [self.delegate didClickVideoWithUrl:self.videoUrl];
    }
}


@end
