//
//  MyBannerView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/8.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "MyBannerView.h"
#import "IEBanner.h"
#import "IEHomeBannerView.h"

@implementation MyBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        IEHomeBannerView *bannerView = [[IEHomeBannerView alloc] initWithFrame:CGRectZero];
        IEBanner *banner = [IEBanner new];
        bannerView.banners = @[banner, banner, banner];
        [self addSubview:bannerView];
        [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

@end
