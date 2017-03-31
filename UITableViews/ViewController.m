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
#import "ZLPhotoPickerBrowserViewController.h"

#import "BaseInfoCell.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
BaseInfoCellDelegate
>

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
    
}
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LCCellConfig *cellConfig = self.dataArray[indexPath.row];
    
    // 拿到对应cell并根据模型显示
    BaseInfoCell *cell = nil;
    cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.infoArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    if ([cell isKindOfClass:[PhotosCell class]]) {
        
    }
    
    return cell;
    
}
- (void)didClickImageAtIndex:(NSInteger)index withAssets:(NSArray *)assets
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    pickerBrowser.photos = assets;
    // 当前选中的值
    pickerBrowser.currentIndex = indexPath.row;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
    
}
-(void)didClickVideoWithUrl:(NSString *)videoUrl
{
    [self sharePush];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCCellConfig *cellConfig = self.dataArray[indexPath.row];
    Class cellClass = NSClassFromString(cellConfig.className);
    
    return [cellConfig heightCachedWithCalculateBlock:^CGFloat{
        return [cellClass returnCellHeight: self.infoArray[indexPath.row]];
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击Cell");
    
}
#pragma mark - get
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    _mainTableView.backgroundColor = [UIColor lightGrayColor];
    return _mainTableView;
}
- (id)getJsonDataJsonname:(NSString *)jsonname
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonname ofType:@"geojson"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        return jsonObj;
    }
}
- (NSMutableArray *)infoArray
{
    
    if (!_infoArray) {
        
        _infoArray = [NSMutableArray new];
        
        NSArray *datas = [self getJsonDataJsonname:@"SheepInfo"][@"data"];
        for (NSDictionary *dict in datas) {
            InfoModel *model = [InfoModel new];
            model.type  = dict[@"type"];
            model.time  = dict[@"time"];
            model.title = dict[@"title"];
            model.identifyUrl = nil;
            model.infoArray = dict[@"infoArray"];
            [_infoArray addObject:model];
            
        }        
    }
    
    return _infoArray;
}


- (NSMutableArray *)dataArray
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
