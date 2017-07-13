//
//  MessageSender.m
//  UITableViews
//
//  Created by 李承 on 2017/4/10.
//  Copyright © 2017年 LC. All rights reserved.
//


#import "MessageSender.h"

@implementation MessageSender

static id sharedMessageSender = nil;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (sharedMessageSender == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            sharedMessageSender = [super allocWithZone:zone];
        });
    }
    return sharedMessageSender;
    
}
-(instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedMessageSender = [super init];
        // to do ?
        
    });
    return sharedMessageSender;
}
+(instancetype)sharedMessageSender
{
    return [[self alloc]init];
}
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return sharedMessageSender;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return sharedMessageSender;
}

-(void)sendMessageWithNumber:(NSString *)Number WithContent:(BaseMessage *)content
{
    NSLog(@"打印数据：%@%@",Number,content);
    
    
}
- (void)sendMessage:(BaseMessage *)message withStrategy:(MessageSendStrategy)strategy
{
   
     [self.strategyList[strategy] invoke];
    
    
}

-(NSArray *)strategyList{
    if (!_strategyList) {
        //NSInvocation;用来包装方法和对应的对象，它可以存储方法的名称，对应的对象，对应的参数,
        /*
         NSMethodSignature：签名：再创建NSMethodSignature的时候，必须传递一个签名对象，签名对象的作用：用于获取参数的个数和方法的返回值
         */
        //创建签名对象的时候不是使用NSMethodSignature这个类创建，而是方法属于谁就用谁来创建
        NSMethodSignature*signature = [MessageSender instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:WithContent:)];
        //1、创建NSInvocation对象
        NSInvocation*TextSenderInvocation = [NSInvocation invocationWithMethodSignature:signature];
        TextSenderInvocation.target = self;
        //invocation中的方法必须和签名中的方法一致。
        TextSenderInvocation.selector = @selector(sendMessageWithNumber:WithContent:);
        /*第一个参数：需要给指定方法传递的值
         第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
        //第二个参数：需要给指定方法的第几个参数传值
        NSString*number = @"1111";
        //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
        [TextSenderInvocation setArgument:&number atIndex:2];
        NSString*number2 = @"啊啊啊";
        [TextSenderInvocation setArgument:&number2 atIndex:3];
        //2、调用NSInvocation对象的invoke方法
        //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
        
        _strategyList = @[TextSenderInvocation];
    }
    
    return _strategyList;
}

@end
