//
//  GBYMineSettingThemeViewController.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/21.
//

#import "GBYMineSettingThemeViewController.h"
#import "GBYMineSettingThemeTableViewCell.h"
#import "ThemeColorManager.h"

static NSString *const mineSettingThemeTableViewCellID = @"mineSettingThemeTableViewCellID";

@interface GBYMineSettingThemeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mineTableView;

@property (nonatomic, copy) NSArray *mineTabDataArray;

@property (nonatomic, copy) NSString *switchStateStr;

@property (nonatomic, assign) NSInteger currentIndex;   //当前点击的cell的索引

@end

@implementation GBYMineSettingThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationView.navigationTitleLabel.text = @"深色模式";
    self.currentIndex = -1;
    [self setMineControlInit];
}

- (void)setMineControlInit {
    [self.view addSubview:self.mineTableView];
    self.mineTableView.lee_theme
    .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
    .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
    if (systemSwitchState()) {
        self.mineTabDataArray = @[@[@"跟随系统"]];
    } else {
        self.mineTabDataArray = @[@[@"跟随系统"], @[@"普通模式", @"深色模式"]];
    }
}

#pragma mark
#pragma marl -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.mineTabDataArray[section];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mineTabDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GBYMineSettingThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineSettingThemeTableViewCellID];
        if (!cell) {
            cell = [[GBYMineSettingThemeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineSettingThemeTableViewCellID];
        }
        cell.textLabel.text = self.mineTabDataArray[indexPath.section][indexPath.row];
        cell.cellStyle = GBYMineSettingThemeTableViewCellStyleSwitch;
        @weakify(self);
        cell.switchSelectStateBlock = ^(BOOL switchState) {
            @strongify(self);
            [self _setSwtichStateConfig:switchState];
        };
        if (systemSwitchState()) {
            cell.cellSwitch.on = YES;
        } else {
            if (self.switchStateStr.length == 0) {
                if (systemSwitchState()) {
                    cell.cellSwitch.on = YES;
                } else {
                    cell.cellSwitch.on = NO;
                }
            } else {
                if ([self.switchStateStr isEqualToString:@"1"]) {
                    cell.cellSwitch.on = YES;
                } else {
                    cell.cellSwitch.on = NO;
                }
            }
        }
        cell.lee_theme
        .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
        .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
        cell.textLabel.lee_theme
        .LeeAddTextColor(DAY, [UIColor blackColor])
        .LeeAddTextColor(NIGHT, [UIColor whiteColor]);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        GBYMineSettingThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineSettingThemeTableViewCellID];
        if (!cell) {
            cell = [[GBYMineSettingThemeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineSettingThemeTableViewCellID];
        }
        cell.textLabel.text = self.mineTabDataArray[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.cellStyle = GBYMineSettingThemeTableViewCellStyleSelectImage;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (darkThemeState()) {
            if (indexPath.row == 1) {
                self.currentIndex = 1;
                cell.selectThemeImage.image = [UIImage imageNamed:@"selectTheme"];
            } else {
                cell.selectThemeImage.image = [UIImage imageNamed:@""];
            }
        } else {
            if (indexPath.row == 0) {
                self.currentIndex = 0;
                cell.selectThemeImage.image = [UIImage imageNamed:@"selectTheme"];
            } else {
                cell.selectThemeImage.image = [UIImage imageNamed:@""];
            }
        }
        cell.lee_theme
        .leeAddBackgroundColor(DAY, UIRGBColor(255, 255, 255))
        .leeAddBackgroundColor(NIGHT, UIRGBColor(40, 40, 40));
        cell.textLabel.lee_theme
        .LeeAddTextColor(DAY, [UIColor blackColor])
        .LeeAddTextColor(NIGHT, [UIColor whiteColor]);
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15*kXX, 0, kScreenW - 30*kXX, 30*kYY)];
        label.text = @"手动选择";
        label.lee_theme
        .LeeAddTextColor(DAY, [UIColor blackColor])
        .LeeAddTextColor(NIGHT, [UIColor whiteColor]);
        [view addSubview:label];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30*kYY;
    }
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == indexPath.row) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSIndexPath *oldPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:1];
    GBYMineSettingThemeTableViewCell *newCell = (GBYMineSettingThemeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    newCell.selectThemeImage.image = [UIImage imageNamed:@"selectTheme"];
    self.currentIndex = indexPath.row;
    
    GBYMineSettingThemeTableViewCell *oldCell = (GBYMineSettingThemeTableViewCell *)[tableView cellForRowAtIndexPath:oldPath];
    oldCell.selectThemeImage.image = [UIImage imageNamed:@""];
    if (indexPath.section == 1) {
        [self _setThemeColorConfig:indexPath.row];
    }
}

- (void)_setSwtichStateConfig:(BOOL)state {
    if (state) {
        /// 设置跟随系统，亮色和深色的本地不需要判断了
        setSystemSwitchState(YES);
        if ([self setSystemColorConfig]) {
            setDarkThemeState(YES);
            setLightThemeState(NO);
            [ThemeColorManager startTheme:NIGHT];
        } else {
            setDarkThemeState(NO);
            setLightThemeState(YES);
            [ThemeColorManager startTheme:DAY];
        }
        self.mineTabDataArray = @[@[@"跟随系统"]];
    } else {
        /// 设置不跟随系统，亮色和深色的本地需要判断一下
        setSystemSwitchState(NO);
        setDarkThemeState(NO);
        setLightThemeState(YES);
        [ThemeColorManager startTheme:DAY];
        self.mineTabDataArray = @[@[@"跟随系统"], @[@"普通模式", @"深色模式"]];
    }
    
    self.switchStateStr = [NSString stringWithFormat:@"%@", @(state)];
    [self.mineTableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"settingThemeChangeNotice" object:nil userInfo:@{@"setState": [NSString stringWithFormat:@"%@", @(state)]}];
}

- (BOOL)setSystemColorConfig {
    if(@available(iOS 13.0,*)){
        return (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark);
    }
    return NO;
}

- (void)_setThemeColorConfig:(NSInteger)index {
    if (index == 0) {
        setLightThemeState(YES);
        setDarkThemeState(NO);
    } else {
        setLightThemeState(NO);
        setDarkThemeState(YES);
    }
   
    if ([[ThemeColorManager currentThemeTag] isEqualToString:DAY]) {
        [ThemeColorManager startTheme:NIGHT];
    } else {
        [ThemeColorManager startTheme:DAY];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"settingThemeChangeNotice" object:nil userInfo:@{@"setState": @"0"}];
}

#pragma mark
#pragma mark --
- (UITableView *)mineTableView {
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenW, kScreenH - kNavigationBarHeight - kTabbarHeight) style:UITableViewStyleGrouped];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
        _mineTableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _mineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 15.0, *)) {
            _mineTableView.sectionHeaderTopPadding = 0;
        }
    }
    return _mineTableView;
}

@end
