//
//  ElementView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/2/27.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "ElementView.h"
#import <Masonry/Masonry.h>
#import "ElementAttributes.h"
#import <SDWebImage/SDWebImage.h>

@interface ElementView()

@property (nonatomic, strong) UILabel *titleLabel;              // 标题
@property (nonatomic, strong) UILabel *contentTextLabel;        // 内容文案
@property (nonatomic, strong) UIImageView *iconImageView;       // 图标
@property (nonatomic, assign) BOOL loadURL;                     // 使用URL加载
@property (nonatomic, strong) ElementAttributes *attributes;    // 元素属性

@end

@implementation ElementView

- (instancetype)initWithAttributes:(ElementAttributes *)attributes {
    self = [super initWithFrame:CGRectMake(0, 0, attributes.elementSize.width, attributes.elementSize.height)];
    if (self) {
        self.backgroundColor = attributes.themeColor;
        if (attributes.cornerRadius > 0) {
            self.layer.masksToBounds = true;
            self.layer.cornerRadius = attributes.cornerRadius;
        }
        _loadURL = [attributes.icon isKindOfClass:[NSURL class]] ? true:false;
        _attributes = attributes;
        [self initElements];
    }
    return self;
}

- (void)initElements {
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    self.titleLabel.textColor = [UIColor colorWithRed:15/255.0 green:24/255.0 blue:38/255.0 alpha:1.0];
    self.titleLabel.numberOfLines = 3;
    self.titleLabel.text = _attributes.title;
    [self addSubview:_titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
    }];
    
    self.contentTextLabel = [UILabel new];
    self.contentTextLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
    self.contentTextLabel.textColor = [UIColor colorWithRed:110/255.0 green:117/255.0 blue:128/255.0 alpha:1.0];
    self.contentTextLabel.numberOfLines = 1;
    self.contentTextLabel.text = _attributes.contentText;
    [self addSubview:_contentTextLabel];
    [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
    }];
    
    self.iconImageView = [UIImageView new];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_iconImageView];
    if (_loadURL) {
        [self.iconImageView sd_setImageWithURL:_attributes.icon];
    } else {
        self.iconImageView.image = _attributes.icon;
    }
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self).offset(-12);
        make.size.mas_offset(self.attributes.iconSize);
    }];
}

@end
