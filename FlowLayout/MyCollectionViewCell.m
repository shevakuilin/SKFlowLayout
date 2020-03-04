//
//  MyCollectionViewCell.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/2/29.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "ElementView.h"
#import <Masonry/Masonry.h>
#import "ElementAttributes.h"
#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell()

@property (nonatomic, strong) ElementView *elementView;

@end

@implementation MyCollectionViewCell

- (void)setAttributes:(ElementAttributes *)attributes {
    _attributes = attributes;
    self.elementView = [[ElementView alloc] initWithAttributes:attributes];
    [self addSubview:_elementView];
    [self.elementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


@end
