//
//  IEHomeBannerCollectionViewCell.m
//  i_ExhibitionPublic
//
//  Created by ShevaKuilin on 2019/9/25.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import <Masonry.h>
#import "IEHomeBannerCollectionViewCell.h"

@interface IEHomeBannerCollectionViewCell()

@property (nonatomic, strong) UIImageView *bannerView;

@end

@implementation IEHomeBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElements];
    }
    return self;
}

- (void)initElements {
    // Banner 阴影
//    UIImageView *shadowView = [UIImageView new];
//    shadowView.backgroundColor = [UIColor clearColor];
////    shadowView.layer.shadowColor = ColorRGBA(0, 0, 0, 0.08).CGColor;
////    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
////    shadowView.layer.shadowOpacity = 1;
////    shadowView.layer.shadowRadius = 3;
//    [self addSubview:shadowView];
//    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    
    self.bannerView = [UIImageView new];
    self.bannerView.contentMode = UIViewContentModeScaleAspectFill;
    self.bannerView.layer.masksToBounds = true;
//    self.bannerView.layer.cornerRadius = 5;
    self.bannerView.backgroundColor = MainDefaultImageBgColor;
    self.bannerView.layer.masksToBounds = true;
    self.bannerView.layer.cornerRadius = 25;
    self.bannerView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [self addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(4, 0, 17, 0));
    }];
}

- (void)setBanner:(NSString *)imageUrl {
//    NSURL *imageURL = [NSURL URLWithString:imageUrl];
//    if (imageURL.host) {
////        [self.bannerView ie_transitionFadeLoadImage:[NSURL URLWithString:imageUrl] placeholderImage:nil];
//    } else {
//        self.bannerView.image = [UIImage imageNamed:imageUrl];
//    }
    self.bannerView.backgroundColor = ColorRGB(113, 124, 192);
}

@end
