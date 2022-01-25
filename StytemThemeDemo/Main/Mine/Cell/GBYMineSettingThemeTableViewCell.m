//
//  GBYMineSettingThemeTableViewCell.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/21.
//

#import "GBYMineSettingThemeTableViewCell.h"

@interface GBYMineSettingThemeTableViewCell ()


@end

@implementation GBYMineSettingThemeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self cellInit];
    }
    return self;
}

- (void)cellInit {
    
    self.cellSwitch = [[UISwitch alloc] init];
    [self.cellSwitch addTarget:self action:@selector(cellSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
    self.selectThemeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20*kYY, 20*kYY)];
    self.selectThemeImage.contentMode = UIViewContentModeScaleAspectFill;
    self.selectThemeImage.clipsToBounds = YES;
}


- (void)cellSwitchChange:(UISwitch *)sender {
    if (self.switchSelectStateBlock) {
        self.switchSelectStateBlock(sender.on);
    }
}


- (void)setCellStyle:(GBYMineSettingThemeTableViewCellStyle)cellStyle {
    _cellStyle = cellStyle;
    if (cellStyle == GBYMineSettingThemeTableViewCellStyleDefault) {
        self.accessoryView = nil;
    } else if (cellStyle == GBYMineSettingThemeTableViewCellStyleSwitch) {
        self.accessoryView = self.cellSwitch;
    } else {
        self.accessoryView = self.selectThemeImage;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
