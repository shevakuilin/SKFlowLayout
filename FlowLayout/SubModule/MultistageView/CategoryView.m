//
//  CategoryView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/9.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "CategoryView.h"

@interface CategoryView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.titleLabel.textColor = Color16Hex(0x0F1826);
        self.titleLabel.numberOfLines = 1;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-45);
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

- (void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    self.titleLabel.text = categoryName;
}

@end
