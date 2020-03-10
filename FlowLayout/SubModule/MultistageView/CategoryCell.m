//
//  CategoryCell.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "NodeModel.h"
#import "CategoryCell.h"

static CGFloat const leftMargin = 30.0; //left indentation
#define RGB(r, g, b, a)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define  RandomColor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1.0)

@interface CategoryCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        self.titleLabel.textColor = Color16Hex(0x0F1826);
        self.titleLabel.numberOfLines = 1;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-45);
        }];
        
        UIImageView *bottomLine = [UIImageView new];
        bottomLine.backgroundColor = Color16Hex(0xF5F6FA);
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-0.5);
            make.height.offset(0.5);
        }];
    }
    return self;
}

- (void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    self.titleLabel.text = categoryName;
}

- (void)setNode:(NodeModel *)node{
    _node = node;
    self.titleLabel.text = node.name;

    //set indentation
    CGFloat indentationX = (node.level-1)*leftMargin;
    [self moveNode:indentationX];
    
    //text color
    CGFloat rgbValue = (node.level-1)*50;
    _nodeLabel.textColor  = RGB(rgbValue, rgbValue, rgbValue, 1.0);
    
    
    _nodeLabel.text = node.name;
    if (node.isExpand || node.isLeaf) {
        _leftImage.image = [UIImage imageNamed:@"YK_minus"];
    }else{
        _leftImage.image = [UIImage imageNamed:@"YK_plus"];
    }
    
    //hidden left log for leaf node or not
   // _leftImage.hidden = node.isLeaf;
}

- (void)moveNode:(CGFloat)indentationX{
    CGFloat cellHeight = _rect.size.height;
    CGFloat cellWidth  = _rect.size.width;
    
    CGRect frame1 = CGRectMake(0, (cellHeight-leftMargin)/2, leftMargin, leftMargin);
    frame1.origin.x = indentationX;
    _leftImage.frame = frame1;
    
    CGRect frame = CGRectMake(leftMargin, 0, cellWidth-leftMargin, cellHeight);
    frame.origin.x = leftMargin+indentationX;
    _nodeLabel.frame = frame;
    
    CGRect frame2 = CGRectMake(0, cellHeight-1, cellWidth, 1);
    frame2.origin.x = indentationX;
    _line.frame = frame2;
}

@end
