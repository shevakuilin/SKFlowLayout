//
//  IEHomeCenterBannerView.m
//  i_ExhibitionPublic
//
//  Created by ShevaKuilin on 2019/12/3.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import "IEBanner.h"
#import <Masonry.h>
//#import "IEConfigRouter.h"
#import "IEHomeCenterBannerView.h"

@interface IEHomeCenterBannerView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation IEHomeCenterBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElements];
    }
    return self;
}

- (void)initElements {
    self.imageView = [UIImageView new];
    self.imageView.frame = CGRectMake(0, 0, ScreenWidth, 75);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = true;
//    @weakify(self)
//    [self.imageView click_handleBlock:^{
//        // - Note: 跳转逻辑
//        @strongify(self)
////        [IEConfigRouter routerDistributeWithPushType:self.adBanner.pushType argument:self.adBanner.argument];
//    }];
    [self addSubview:self.imageView];
}

- (void)setAdBanner:(IEBanner *)adBanner {
    _adBanner = adBanner;
    self.imageView.backgroundColor = [UIColor greenColor];
//    NSURL *url = [NSURL URLWithString:adBanner.coverIcon];
//    [self.imageView ie_transitionFadeLoadImage:url placeholderImage:nil];
}

@end
