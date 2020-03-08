//
//  IEHomeBannerView.h
//  i_ExhibitionPublic
//
//  首页 Banner 控件
//
//  Created by ShevaKuilin on 2019/9/25.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IEBanner;

NS_ASSUME_NONNULL_BEGIN

@interface IEHomeBannerView : UIView

@property (nonatomic, copy) NSArray<IEBanner *> *banners; // Banner 广告URL

@end

NS_ASSUME_NONNULL_END
