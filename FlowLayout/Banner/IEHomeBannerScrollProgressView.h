//
//  IEHomeBannerScrollProgressView.h
//  i_ExhibitionPublic
//
//  首页 Banner 滚动进度控件
//
//  Created by ShevaKuilin on 2019/9/25.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IEHomeBannerScrollProgressView : UIView

@property (nonatomic, assign) NSUInteger itemCount; // Banner 数量

/** 同步滚动进度
 *
 * @param index     当前显示的 Banner 位置
 *
 */
- (void)syncScrollProgress:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
