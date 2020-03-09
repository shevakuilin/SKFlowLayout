//
//  MyHeaderView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/6.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "MyHeaderView.h"

@interface MyHeaderView()

@property (nonatomic, strong) UIView *topSeparate;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIButton *checkButton;

@end

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.topSeparate = [UIView new];
        self.topSeparate.backgroundColor = ColorRGB(245, 246, 250);
        [self addSubview:self.topSeparate];
        [self.topSeparate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.offset(0);
        }];
        
        self.titleLable = [UILabel new];
        self.titleLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        self.titleLable.text = @"展馆地图";
        self.titleLable.textColor = Color16Hex(0x0F1826);
        [self addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topSeparate.mas_bottom).offset(11);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
        
        UIImageView *bottomLine = [UIImageView new];
        bottomLine.backgroundColor = Color16Hex(0xF5F6FA);
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-0.5);
            make.height.offset(0.5);
        }];
        
        self.checkButton.hidden = true;
        [self addSubview:self.checkButton];
        [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLable.mas_centerY);
            make.right.equalTo(self).offset(-15);
            make.size.mas_offset(CGSizeMake(60, 20));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = title;
    self.checkButton.hidden = [title isEqualToString:@"展馆地图"] ? true:false;
    if (self.checkButton.hidden) {
        [self.topSeparate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
    } else {
        [self.topSeparate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(8);
        }];
    }
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton new];
        [_checkButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_checkButton setTitleColor:Color16Hex(0x3385FF) forState:UIControlStateNormal];
        _checkButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        _checkButton.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _checkButton;
}

@end
