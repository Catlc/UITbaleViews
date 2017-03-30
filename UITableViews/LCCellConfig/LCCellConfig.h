//
//  LCCellConfig.h
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

/**
     Config - 配置
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LCCellConfig : NSObject

/// cell 类名
@property (nonatomic,strong)NSString *className;

///标题 -
@property (nonatomic,strong)NSString *title;

///显示模型的方法
@property(nonatomic ,assign)SEL showInfoMethod;

/// Cell高度（固定高度）
@property(nonatomic,assign)CGFloat heightOfCell;

/// 预留属性detail
@property(nonatomic,strong)NSString *detail;

///指定重用ID 不赋值使用类名
@property(nonatomic,strong)NSString *reuseID;

#pragma mark -Core

/**
 @brief 便利构造器

 @param className 类名
 @param title 标题
 @param showInfoMethod 显示数据模型
 @param heightOfCell cell高度
 @return instancetype
 */

+ (instancetype)cellConfigWithClassName:(NSString *)className
                                 title:(NSString *)title
                        showInfoMethod:(SEL)showInfoMethod
                          heightOfCell:(CGFloat)heightOfCell;
/// 根据cellConfig 生成Cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel;

/// 根据cellConfig 生成Cell，重用ID为cell类名 可用Nib
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel
                                             isNib:(BOOL)isNib;

#pragma mark - Dynamic Height 
/// cell动态高度（计算后缓存到这个字段，避免重复计算）
@property (nonatomic,assign)CGFloat dynamicHeightOfCell;

///缓存高度
- (CGFloat)heightCachedWithCalculateBlock:(CGFloat (^)(void))block;

#pragma mark -Assist
/// 根据类名，快捷注册cell
- (void)registerForTableView:(UITableView *)tableView;


@end
