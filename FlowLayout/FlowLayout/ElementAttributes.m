//
//  ElementAttributes.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/2/27.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "ElementAttributes.h"

@implementation ElementAttributes

- (instancetype)init {
    self = [super init];
    if (self) {
        _scale = CGSizeMake(1.42, 1);
        _themeColor = [UIColor whiteColor];
        _title = @"";
        _contentText = @"";
        _icon = nil;
        _cornerRadius = 0;
    }
    return self;
}

- (CGFloat)value {
    return 75;
}

- (CGSize)iconSize {
    return CGSizeMake(35, 35);
}

- (CGSize)elementSize {
    CGSize size = CGSizeMake(_scale.width * self.value, _scale.height * self.value);
    return size;
}

@end
