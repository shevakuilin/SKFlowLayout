//
//  DateCell.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "DateCell.h"

@interface DateCell()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *conferenceStatusLabel;
@property (nonatomic, strong) UILabel *expandStatusLabel;

@end

@implementation DateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = ColorRGB(253, 250, 254);
        
        self.dateLabel = [UILabel new];
        self.dateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        self.dateLabel.textColor = Color16Hex(0x424242);
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
//            make.width.offset(80);
        }];
        
        self.conferenceStatusLabel = [UILabel new];
        self.conferenceStatusLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:7];
        self.conferenceStatusLabel.textColor = Color16Hex(0xC9CED6);
        self.conferenceStatusLabel.text = @"会议进行中";
        [self addSubview:self.conferenceStatusLabel];
        [self.conferenceStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.dateLabel.mas_centerY);
            make.left.equalTo(self.dateLabel.mas_right).offset(5.5);
//            make.width.offset(80);
        }];
        
        self.expandStatusLabel = [UILabel new];
        self.expandStatusLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:8];
        self.expandStatusLabel.textColor = Color16Hex(0x6E7580);
        self.expandStatusLabel.text = @"展开";
        [self addSubview:self.expandStatusLabel];
        [self.expandStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.conferenceStatusLabel.mas_centerY);
            make.right.equalTo(self).offset(-15);
//            make.width.offset(80);
        }];
    }
    return self;
}

- (void)setDateStr:(NSString *)dateStr {
    _dateStr = dateStr;
    self.dateLabel.text = dateStr;
}

@end
