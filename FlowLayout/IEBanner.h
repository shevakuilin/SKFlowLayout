//
//  IEBanner.h
//  i_ExhibitionPublic
//
//  Banner 数据模型
//
//  Created by ShevaKuilin on 2019/11/19.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IEBanner : NSObject

@property (nonatomic, copy) NSString *coverIcon;    // 图片
@property (nonatomic, copy) NSString *exhibitionId; // 展会Id
@property (nonatomic, copy) NSString *bannerId;     // Banner Id
@property (nonatomic, copy) NSString *showType;     // 展示类型
@property (nonatomic, copy) NSString *title;        // 标题
@property (nonatomic, copy) NSString *pushType;     // 跳转类型
@property (nonatomic, copy) NSString *argument;     // 跳转参数 [链接或id]

@end

NS_ASSUME_NONNULL_END
