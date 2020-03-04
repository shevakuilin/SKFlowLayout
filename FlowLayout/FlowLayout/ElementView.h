//
//  ElementView.h
//  FlowLayout
//
//  元素视图
//
//  Created by ShevaKuilin on 2020/2/27.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ElementAttributes;

NS_ASSUME_NONNULL_BEGIN

@interface ElementView : UIView

- (instancetype)initWithAttributes:(ElementAttributes *)attributes;

@end

NS_ASSUME_NONNULL_END
