//
//  MyMultistageView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/9.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "MyMultistageView.h"

@interface MyMultistageView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyMultistageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.scrollEnabled = false;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.showsHorizontalScrollIndicator = false;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
        _tableView.backgroundColor = ColorRGB(245, 246, 250);;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
