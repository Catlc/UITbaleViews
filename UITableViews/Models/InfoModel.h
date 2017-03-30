//
//  InfoModel.h
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

@property (nonatomic,copy)NSString  *type;

@property (nonatomic,copy)NSString  *time;

@property (nonatomic,copy)NSString  *identifyUrl;

@property (nonatomic,copy)NSString  *title;


//每行cell的详细数据
@property (nonatomic,strong)NSArray *infoArray;




@end
