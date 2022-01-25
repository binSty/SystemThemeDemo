//
//  GBYMineViewController.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "GBYMineViewController.h"
#import "GBYMineSettingViewController.h"

static NSString *const mineTableViewCellID = @"mineTableViewCellID";

@interface GBYMineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mineTableView;

@property (nonatomic, copy) NSArray *mineTabDataArray;

@end

@implementation GBYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView.navigationTitleLabel.text = @"我的";
    [self setMineControlInit];
}

- (void)setMineControlInit {
    [self.view addSubview:self.mineTableView];
    self.mineTableView.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    self.mineTabDataArray = @[@"设置"];
}

#pragma mark
#pragma marl -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mineTabDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineTableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineTableViewCellID];
    }
    cell.textLabel.text = self.mineTabDataArray[indexPath.row];
    cell.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    cell.textLabel.lee_theme
    .LeeAddTextColor(DAY, [UIColor blackColor])
    .LeeAddTextColor(NIGHT, [UIColor whiteColor]);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GBYMineSettingViewController *mineSettingVC = [[GBYMineSettingViewController alloc] init];
    [self.navigationController pushViewController:mineSettingVC animated:YES];
}

#pragma mark
#pragma mark --
- (UITableView *)mineTableView {
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenW, kScreenH - kNavigationBarHeight - kTabbarHeight) style:UITableViewStylePlain];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _mineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mineTableView;
}

@end
