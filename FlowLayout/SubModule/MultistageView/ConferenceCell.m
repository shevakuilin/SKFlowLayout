//
//  ConferenceCell.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "ConferenceCell.h"

@interface ConferenceCell()

@property (nonatomic, strong) UILabel *conferenceTimeLabel;
@property (nonatomic, strong) UILabel *conferenceTitleLabel;
@property (nonatomic, strong) UILabel *conferenceLocationLabel;
@property (nonatomic, strong) UILabel *speakerLable;
@property (nonatomic, strong) UILabel *languageLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ConferenceCell

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
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *leftDot = [UIImageView new];
        leftDot.backgroundColor = Color16Hex(0x5CDBD3);
        leftDot.layer.masksToBounds = true;
        leftDot.layer.cornerRadius = 5;
        [self addSubview:leftDot];
        [leftDot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(15);
            make.size.mas_offset(CGSizeMake(10, 10));
        }];
        
        self.conferenceTimeLabel = [UILabel new];
        self.conferenceTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        self.conferenceTimeLabel.textColor = Color16Hex(0x0F1826);
        self.conferenceTimeLabel.numberOfLines = 1;
        [self addSubview:self.conferenceTimeLabel];
        [self.conferenceTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(39.5);
            make.centerY.equalTo(leftDot.mas_centerY);
            make.right.equalTo(self).offset(-85);
        }];
        
        self.conferenceTitleLabel = [UILabel new];
        self.conferenceTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        self.conferenceTitleLabel.textColor = Color16Hex(0x6E7580);
        self.conferenceTitleLabel.numberOfLines = 0;
        [self addSubview:self.conferenceTitleLabel];
        [self.conferenceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conferenceTimeLabel.mas_left);
            make.top.equalTo(self.conferenceTimeLabel.mas_bottom).offset(16);
            make.right.equalTo(self).offset(-15);
        }];
        
        self.conferenceLocationLabel = [UILabel new];
        self.conferenceLocationLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        self.conferenceLocationLabel.textColor = Color16Hex(0xC9CED6);
        self.conferenceLocationLabel.numberOfLines = 1;
        [self addSubview:self.conferenceLocationLabel];
        [self.conferenceLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conferenceTitleLabel.mas_left);
            make.top.equalTo(self.conferenceTitleLabel.mas_bottom).offset(16);
            make.right.equalTo(self).offset(-15);
        }];
        
        self.statusLabel = [UILabel new];
        self.statusLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:8];
        self.statusLabel.textColor = Color16Hex(0xFF4A76);
        self.statusLabel.text = @" 进行中 ";
        self.statusLabel.backgroundColor = ColorRGBA(255, 120, 117, 0.2);
        [self addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftDot.mas_centerY);
            make.right.equalTo(self).offset(-15);
        }];
        
        self.speakerLable = [UILabel new];
        self.speakerLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        self.speakerLable.textColor = Color16Hex(0xC9CED6);
        self.speakerLable.numberOfLines = 1;
        [self addSubview:self.speakerLable];
        [self.speakerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conferenceTitleLabel.mas_left);
            make.top.equalTo(self.conferenceLocationLabel.mas_bottom).offset(8);
            make.right.equalTo(self).offset(-15);
        }];
        
        self.languageLabel = [UILabel new];
        self.languageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        self.languageLabel.textColor = Color16Hex(0xC9CED6);
        self.languageLabel.numberOfLines = 1;
        [self addSubview:self.languageLabel];
        [self.languageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conferenceTitleLabel.mas_left);
            make.top.equalTo(self.speakerLable.mas_bottom).offset(8);
            make.right.equalTo(self).offset(-15);
        }];
        
        self.numberLabel = [UILabel new];
        self.numberLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        self.numberLabel.textColor = Color16Hex(0xC9CED6);
        self.numberLabel.numberOfLines = 1;
        [self addSubview:self.numberLabel];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.conferenceTitleLabel.mas_left);
            make.top.equalTo(self.languageLabel.mas_bottom).offset(8);
            make.right.equalTo(self).offset(-15);
        }];
        
    }
    return self;
}

- (void)setConference:(NSString *)conference {
    _conference = conference;
    self.conferenceTimeLabel.text = conference;
    self.conferenceTitleLabel.text = @"科技材料引领时尚未来 - SYCORE-TEX黑科技让春装护寒冬\nTechnical Materials Lead the Fashion Future-SYCORE-TEX Black Technology Makes Spring Wear for Winter";
    self.conferenceLocationLabel.text = @"4.1号馆 K112     热点交流Talking Point";
    self.speakerLable.attributedText = [@"演讲者 邹朦胧" highLightContent:@"邹朦胧" highLightColor:Color16Hex(0x6E7580)];
    self.languageLabel.attributedText = [@"语言  普通话" highLightContent:@"普通话" highLightColor:Color16Hex(0x6E7580)];
    self.numberLabel.attributedText = [@"已报名 3人" highLightContent:@"3人" highLightColor:Color16Hex(0x6E7580)];
}

@end
