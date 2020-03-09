//
//  MySearchBar.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/8.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "MySearchBar.h"

@implementation MySearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titileLabel = [UILabel new];
        titileLabel.text = @"请输入搜索内容";
        titileLabel.font = [UIFont fontWithName:@"PingFangSC" size:13];
        titileLabel.textAlignment = NSTextAlignmentCenter;
        titileLabel.textColor = [UIColor whiteColor];
        titileLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:titileLabel];
        [titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(15, 15, 15, 15));
        }];
    }
    return self;
}

@end
