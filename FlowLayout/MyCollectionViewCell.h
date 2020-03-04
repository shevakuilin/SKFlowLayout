//
//  MyCollectionViewCell.h
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/2/29.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ElementAttributes;

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ElementAttributes *attributes;

@end

NS_ASSUME_NONNULL_END
