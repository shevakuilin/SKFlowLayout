//
//  ElementAttributes.h
//  FlowLayout
//
//  元素属性
//
//  Created by ShevaKuilin on 2020/2/27.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ElementAttributes : NSObject

@property (nonatomic, assign, readwrite) CGSize scale;          // 宽高比 [默认1.42:1]
@property (nonatomic, strong, readwrite) UIColor *themeColor;   // 主题色 [默认白色]
@property (nonatomic, copy, readwrite) NSString *title;         // 标题
@property (nonatomic, copy, readwrite) NSString *contentText;   // 内容文字
@property (nonatomic, strong, readwrite) id icon;               // 图标 [泛型，可传入URL或UIImage对象]
@property (nonatomic, assign, readwrite) CGFloat cornerRadius;  // 角半径
@property (nonatomic, assign, readonly) CGFloat value;          // 高度定值
@property (nonatomic, assign, readonly) CGSize iconSize;        // 图标尺寸
@property (nonatomic, assign, readonly) CGSize elementSize;     // 元素尺寸

@end

NS_ASSUME_NONNULL_END
