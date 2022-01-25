//
//  GBYHomeViewController.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/20.
//

#import "GBYHomeViewController.h"
#import "GBYHomeDetailViewController.h"

static NSString *const homeTableViewCellID = @"homeTableViewCellID";

@interface GBYHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *homeTableView;

@property (nonatomic, strong) UISwitch *cellSwitch;

@end

@implementation GBYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView.navigationTitleLabel.text = @"首页";
    [self setHomeControlInit];
}

- (void)setHomeControlInit {
    [self.view addSubview:self.homeTableView];
    self.homeTableView.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    self.homeTableView.lee_theme
    .LeeAddSeparatorColor(DAY, UIColorFromRGB(0xf5f5f5f))
    .LeeAddSeparatorColor(NIGHT, UIRGBColor(60, 60, 121));
}

#pragma mark
#pragma marl -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeTableViewCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index - %ld", indexPath.row];
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
    GBYHomeDetailViewController *mineSettingVC = [[GBYHomeDetailViewController alloc] init];
    [self.navigationController pushViewController:mineSettingVC animated:YES];
}

#pragma mark
#pragma mark --
- (UITableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenW, kScreenH - kNavigationBarHeight - kTabbarHeight) style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        [_homeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:homeTableViewCellID];
        if (@available(iOS 11.0, *)) {
            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _homeTableView;
}
@end
