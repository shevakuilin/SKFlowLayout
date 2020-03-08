//
//  IEHomeBannerScrollProgressView.m
//  i_ExhibitionPublic
//
//  Created by ShevaKuilin on 2019/9/25.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import "IEHomeBannerScrollProgressView.h"

@interface IEHomeBannerScrollProgressView()

@property (nonatomic, assign) NSUInteger highlightIndex;

@end

@implementation IEHomeBannerScrollProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setItemCount:(NSUInteger)itemCount {
    // 清除全部子控件
    [self removeAllSubviews];
    // 限制 Banner 最大数量
    NSUInteger maxCount = itemCount > 5 ? 5:itemCount;
    for (NSUInteger i = 0; i < maxCount; i++) {
        UIImageView *dot = [UIImageView new];
        dot.frame = CGRectMake(i * 25, 0, 20, 2);
        dot.layer.masksToBounds = true;
        dot.layer.cornerRadius = 2.5;
        dot.tag = 888 + i;
        if (i == _highlightIndex) {
            // 默认高亮第一位
            dot.backgroundColor = Color16Hex(0x4791FF);
        } else {
            dot.backgroundColor = Color16Hex(0xC9CED6);
        }
        [self addSubview:dot];
    }
}

- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

#pragma mark - 同步滚动进度

- (void)syncScrollProgress:(NSUInteger)index {
    // 限制最大位置
    NSUInteger maxIndex = index > 3 ? 3:index;
    // 先将所有圆点重置
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *dot = (UIImageView *)subView;
            dot.backgroundColor = Color16Hex(0xC9CED6);
        }
    }
    // 设置指定圆点高亮
    UIImageView *dot = [self viewWithTag:888 + maxIndex];
    dot.backgroundColor = Color16Hex(0x4791FF);
    // 保存当前高亮位置
    self.highlightIndex = index;
}

@end
