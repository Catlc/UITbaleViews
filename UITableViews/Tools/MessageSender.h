//
//  MessageSender.h
//  UITableViews
//
//  Created by 李承 on 2017/4/10.
//  Copyright © 2017年 LC. All rights reserved.
//

typedef NS_ENUM(NSUInteger,MessageSendStrategy)
{
    MessageSendStrategyText = 0,
    MessageSendStrategyImage = 1,
    MessageSendStrategyVoice = 2,
    MessageSendStrategyVideo = 3
};

#import <Foundation/Foundation.h>
#import "BaseMessage.h"

@protocol MessageSenderDelegate<NSObject>

@required

- (void)messageSender:(id)messageSender
didSuccessSendMessage:(BaseMessage *)message
             strategy:(MessageSendStrategy)strategy;

- (void)messageSender:(id)messageSender
   didFailSendMessage:(BaseMessage *)message
             strategy:(MessageSendStrategy)strategy
                error:(NSError *)error;
@end


@interface MessageSender : NSObject

@property (nonatomic, strong) NSArray *strategyList;
@property (nonatomic, weak) id<MessageSenderDelegate> delegate;



+(instancetype)sharedMessageSender;

 
// 然后对外提供一个这样的接口，同时有一个delegate用来回调
- (void)sendMessage:(BaseMessage *)message withStrategy:(MessageSendStrategy)strategy;



@end
