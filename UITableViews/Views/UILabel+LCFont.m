//
//  UILabel+LCFont.m
//  UITableViews
//
//  Created by 李承 on 2017/4/7.
//  Copyright © 2017年 LC. All rights reserved.
//
#define SizeScale ((kHeightOfScreen > 568) ? kHeightOfScreen/568 : 1)

#import "UILabel+LCFont.h"

@implementation UILabel (LCFont)

//+ (void)load{
//    //利用running time运行池的方法在程序启动的时候把两个方法替换
//    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
//    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
//    method_exchangeImplementations(cmp, myCmp);
//}

//- (id)myInitWithFrame:(NSCoder*)aDecode{
//    [self myInitWithFrame:aDecode];
//    if (self) {
//        
//        CGFloat fontSize = self.font.pointSize;
//        self.font = [UIFont systemFontOfSize:fontSize * SizeScale];
//        
//    }
//    return self;
//}

@end
