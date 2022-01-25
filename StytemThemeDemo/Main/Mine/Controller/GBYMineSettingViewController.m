//
//  GBYMineSettingViewController.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/21.
//

#import "GBYMineSettingViewController.h"
#import "GBYMineSettingThemeViewController.h"

static NSString *const mineSettingTableViewCellID = @"mineSettingTableViewCellID";

@interface GBYMineSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mineTableView;

@property (nonatomic, copy) NSArray *mineTabDataArray;

@property (nonatomic, strong) UITableViewCell *stateCell;

@end

@implementation GBYMineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView.navigationTitleLabel.text = @"设置";
    [self setMineControlInit];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:@"settingThemeChangeNotice" object:nil];
}

- (void)themeChange:(NSNotification *)noti {
    NSString *stateString = noti.userInfo[@"setState"];
    if ([stateString isEqualToString:@"1"]) {
        self.stateCell.detailTextLabel.text = @"跟随系统";
    } else {
        if (lightThemeState()) {
            self.stateCell.detailTextLabel.text = @"已关闭";
        } else {
            self.stateCell.detailTextLabel.text = @"已开启";
        }
    }
}

- (void)setMineControlInit {
    [self.view addSubview:self.mineTableView];
    self.mineTableView.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    self.mineTabDataArray = @[@"深色模式"];
}

#pragma mark
#pragma marl -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mineTabDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineSettingTableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mineSettingTableViewCellID];
    }
    cell.textLabel.text = self.mineTabDataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (systemSwitchState()) {
        cell.detailTextLabel.text = @"跟随系统";
    } else {
        if (darkThemeState()) {
            cell.detailTextLabel.text = @"已开启";
        } else {
            cell.detailTextLabel.text = @"已关闭";
        }
    }
    
    cell.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    cell.textLabel.lee_theme
    .LeeAddTextColor(DAY, [UIColor blackColor])
    .LeeAddTextColor(NIGHT, [UIColor whiteColor]);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.stateCell = cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GBYMineSettingThemeViewController *mineSettingVC = [[GBYMineSettingThemeViewController alloc] init];
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
