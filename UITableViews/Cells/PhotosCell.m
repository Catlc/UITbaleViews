//
//  PhotosCell.m
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//



#import "PhotosCell.h"
#import "ZLPhotoPickerBrowserViewController.h"

static const CGFloat picMargin = 4;
static const NSInteger numPicsOfLine = 3;
@interface PhotosCell ()

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic,strong)UIView *pickView;

@end


@implementation PhotosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 get

 @return packView
 */
-(UIView *)pickView
{
    if (!_pickView) {
        _pickView = [UIView new];
        [self.contentView addSubview:_pickView];
    }
    return _pickView;
    
}
+ (CGFloat)returnCellHeight:(InfoModel *)comment
{
    CGFloat width = (kWidthOfScreen - 74 - picMargin * 2) / 3;
    return width * ((comment.infoArray.count - 1) / numPicsOfLine + 1) + 16;
}
-(void)showInfo:(InfoModel *)model
{
    for (UIView *pic in self.pickView.subviews) {
        [pic removeFromSuperview];
    }
    _photos = [NSMutableArray arrayWithCapacity:model.infoArray.count];
    
    CGFloat width = (kWidthOfScreen - 74 - picMargin * 2) / 3;
    
     
    for (int i = 0; i < model.infoArray.count; i++) {
        NSInteger row = i / numPicsOfLine;
        NSInteger col = i % numPicsOfLine;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width + picMargin) * col, (width + picMargin) * row, width, width)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        NSString *imageUrl = model.infoArray[i];
        
        ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
//        photo.photoURL = [NSURL URLWithString:imageUrl];
        photo.photoImage =[UIImage imageNamed:imageUrl];
        [_photos addObject:photo];
        
        [imageView setImage:[UIImage imageNamed:imageUrl]];
        [self.pickView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanPicture:)]];
        imageView.tag = i;
    }
    
    self.pickView.frame = CGRectMake(74, 0, kWidthOfScreen - 74 - picMargin * 2, 0);
    self.pickView.height = width * ((model.infoArray.count - 1) / numPicsOfLine + 1) + 16;
    
}
- (void)scanPicture:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(didClickImageAtIndex:withAssets:)]) {
        [self.delegate didClickImageAtIndex:tap.view.tag withAssets:self.photos];
    }
    
}


@end
