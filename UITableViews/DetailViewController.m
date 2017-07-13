//
//  DetailViewController.m
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "DetailViewController.h"
#import "MessageSender.h"
#import "UIView+ExtendTouchRect.h"

@interface DetailViewController ()
 

@end

@implementation DetailViewController
{
    CGFloat imageviewAngle;
    CGFloat angle;
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    BaseMessage *message = [BaseMessage new];
    [[MessageSender sharedMessageSender] sendMessage:message withStrategy:MessageSendStrategyText];
    
    imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake(90, 90, 100, 100);
    [self.view addSubview:imageView];
    
//    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
//        
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(200, 50, 200, 50));
        
//    }];
    
//    button.touchExtendInset = UIEdgeInsetsMake(-10, -10, -10, -10);
    
    [self startAnimationS];
    
}
-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    imageView.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    angle += 10;
    [self startAnimation];
}

- (void)startAnimationS
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(imageviewAngle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        imageView.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 10; [self startAnimationS];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
