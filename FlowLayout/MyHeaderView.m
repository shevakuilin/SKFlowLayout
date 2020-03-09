//
//  MyHeaderView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/6.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "MyHeaderView.h"

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLable = [UILabel new];
        titleLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        titleLable.text = @"展馆地图";
        titleLable.textColor = Color16Hex(0x0F1826);
        [self addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(11);
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
    }
    return self;
}

@end
