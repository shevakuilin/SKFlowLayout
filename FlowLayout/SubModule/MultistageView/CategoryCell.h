//
//  CategoryCell.h
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

@class NodeModel;
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCell : UITableViewCell

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, strong) NodeModel *node;

@property (nonatomic, strong) UIImageView *leftImage;

@property (nonatomic, strong) UILabel *nodeLabel;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, assign) CGRect rect;

@end

NS_ASSUME_NONNULL_END
