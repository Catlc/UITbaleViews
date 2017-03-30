//
//  ViewController.m
//  UITableViews
//
//  Created by bmxd-002 on 17/3/30.
//  Copyright © 2017年 LC. All rights reserved.
//

#define kMinHeightOfCell 80   // 这里可以给一个最小高度，实际上不会被直接使用


#import "ViewController.h"
#import "DetailViewController.h"
#import "VideoCell.h"
#import "WetherCell.h"
#import "PhotosCell.h"
#import "SheepInfoCell.h"
#import "InfoModel.h"
#import "LCCellConfig.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *infoArray;


@property (nonatomic,strong)InfoModel *infoModel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addAllViews];
    
    NSLog(@"%@",self.infoArray);
    

}
#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LCCellConfig *cellConfig = self.dataArray[indexPath.row];
    NSLog(@"cellClass is %@",cellConfig.className);

    // 拿到对应cell并根据模型显示
    UITableViewCell *cell = nil;
    cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.infoArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCCellConfig *cellConfig = self.dataArray[indexPath.row];
    Class cellClass = NSClassFromString(cellConfig.className);
//    NSLog(@"cellClass is %@",cellConfig.className);

    return [cellConfig heightCachedWithCalculateBlock:^CGFloat{
        return [cellClass returnCellHeight: self.infoArray[indexPath.row]];
    }];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击Cell");
    
}
#pragma mark - get
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    
    return _mainTableView;
}
-(NSMutableArray *)infoArray
{

    if (!_infoArray) {
        
        _infoArray = [NSMutableArray new];
        for (int i = 0; i<4; i++) {
            InfoModel *model = [InfoModel new];
            model.type  = [NSString stringWithFormat:@"%d",i];
            model.time  = [NSString stringWithFormat:@"2017.4.%d",i];
            model.title = [NSString stringWithFormat:@"标题:%d",i];
            model.identifyUrl = nil;
            switch (i) {
                case 0:
                {
                    model.infoArray = @[@"loading1.jpg",@"loading2.jpg",@"loading3.jpg",@"splashscreens.jpg"];
                }
                    break;
                case 1:
                {
                    model.infoArray = @[@"注射：羊三联菌苗 5ml",@"预防:羊快疫，羊肠吐血",@"免疫期：半年"];
                }
                    break;
                case 2:
                {
                    model.infoArray = @[@"fdfd.png"];

                }
                    break;
                case 3:
                {
                    model.infoArray = @[@"天气:多云 -8~5°C",@"湿度:87%",@"风力:西北风2级",@"空气质量指数:30（优）",@"紫外线强度:弱"];

                }
                    break;
                 default:
                    break;
            }
            
            [_infoArray addObject:model];
        }
        
    }
    
    return _infoArray;
}


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSArray *cellClassArray = @[@"PhotosCell",@"SheepInfoCell",@"VideoCell",@"WetherCell"];
        for (InfoModel *model in self.infoArray) {
            
            Class cellClass = NSClassFromString(cellClassArray[[model.type intValue]]);
            NSLog(@"cellClass is %@",NSStringFromClass([cellClass class]));
            
            LCCellConfig *config = [LCCellConfig cellConfigWithClassName:NSStringFromClass([cellClass class]) title:model.title showInfoMethod:@selector(showInfo:) heightOfCell:kMinHeightOfCell];
            
            [_dataArray addObject:config];
        }
        
        
    }
    return _dataArray;
}

#pragma mark - UI
- (void)addAllViews
{
    self.title  = @"安全溯源";
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action: @selector(sharePush)];
    
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action: nil];
    
    NSArray *itemsArr = @[shareItem,cameraItem];
    
    self.navigationItem.rightBarButtonItems = itemsArr;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
}



-(void)sharePush
{
    //
    DetailViewController *detailVc = [DetailViewController new];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
