//
//  SKCollectionViewFlowLayout.m
//  FlowLayout
//
//  参考：https://www.jianshu.com/p/e1d8b51fc2b9
//  https://samwize.com/2015/11/30/understanding-uicollection-flow-layout/
//  https://github.com/czl0325/ZLCollectionView
//  https://www.jianshu.com/p/537c27a07581
//  https://www.jianshu.com/p/7baacb65ae9b
//  https://stackoverflow.com/questions/53605022/changing-uicollectionview-layout-depending-on-section
//  https://github.com/sgr-ksmt/WaterfallLayout
//
//  Created by ShevaKuilin on 2020/3/4.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "SKCollectionViewFlowLayout.h"

@interface SKCollectionViewFlowLayout()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *allLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *itemLayoutAttributes;
@property (nonatomic, strong) NSMutableArray *framePool;
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation SKCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

// 重载 collectionViewContentSize 方法
- (CGSize)collectionViewContentSize {
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return CGSizeMake(self.collectionView.frame.size.width, _contentSize.height);
    } else {
        return CGSizeMake(_contentSize.width, self.collectionView.frame.size.height);
    }
}

// 重载预加载布局属性
- (void)prepareLayout {
    [super prepareLayout];
    // collectionView 的实际大小
    _contentSize = CGSizeZero;
    // 清除旧布局
    [self.allLayoutAttributes removeAllObjects];
    [self.itemLayoutAttributes removeAllObjects];
    // 获取 section 数量
    NSInteger section = [self.collectionView numberOfSections];
    for (NSInteger j = 0; j < section; j++) {
        // 获取每个 section 下 item 的数量
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:j];
        for (NSInteger i = 0; i < itemCount; i++) {
            // 计算布局属性
            UICollectionViewLayoutAttributes *theAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
            [self.itemLayoutAttributes addObject:theAttributes];
        }
        [self.allLayoutAttributes addObject:self.itemLayoutAttributes];
    }
}

// 重载布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 设置 insert
    if (indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6) {
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    // size 默认为 itemSize
    CGSize size = self.itemSize;
    // 从代理方法获取 item 的 size
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)] && [self.collectionView.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)]) {
        // 转换协议，获取 size
        id<UICollectionViewDelegateFlowLayout> flowLayoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        size = [flowLayoutDelegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    // 初始化每个 item 的 frame
    CGRect frame = CGRectZero;
    CGFloat x = 0, y = 0;
    // 判断 collectionView 的滑动方向
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        // 垂直方向滑动
        // 获取 collectionView 的宽度
        CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
        // 设置坐标初始值，默认左对齐
        x = self.sectionInset.left;
        y = self.sectionInset.top;
        // 判断是否为前一个 item
        if (self.itemLayoutAttributes.count > 0) {
            // 从 layoutAttributes 中获取上一个 item 如果获取不到，设置现在的 item 为第一个 item
            UICollectionViewLayoutAttributes *lastLayoutAttributes = self.itemLayoutAttributes.lastObject;
            if (CGRectGetMaxX(lastLayoutAttributes.frame) + self.minimumInteritemSpacing + size.width + self.sectionInset.right > collectionViewWidth) {
                // 如果宽度总和超过总宽度, 改变 y 坐标, 当前的 item 在下一行显示
                y = CGRectGetMaxY(lastLayoutAttributes.frame) + self.minimumLineSpacing;
                if (indexPath.section == 5) {
                    // 碰撞检测
                    x = CGRectGetMinX([self itemCollisionDetectionWithCurrentFrame:CGRectMake(x, y, size.width, size.height)]);                    
                }
            } else {
                // 如果宽度可以插入 item, 修改坐标点, y 轴与上一个 item 平齐, x 轴则为上一个 item 的最右边加上行间距
                x = CGRectGetMaxX(lastLayoutAttributes.frame) + self.minimumInteritemSpacing;
                y = CGRectGetMinY(lastLayoutAttributes.frame);
            }
        }
    } else {
        // 水平方向滑动
        UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
        x = attributes.frame.origin.x;
        y = attributes.frame.origin.y;
    }
    // 判断是否存在 header 视图
    if (!CGSizeEqualToSize(CGSizeZero, self.headerReferenceSize) && indexPath.row == 0 && (indexPath.section == 5 || indexPath.section == 6)) {
        // 添加 header
        UICollectionViewLayoutAttributes *layoutHeader = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
        if (indexPath.section == 5) {
            layoutHeader.frame = CGRectMake(0, y - self.minimumInteritemSpacing, [UIScreen mainScreen].bounds.size.width, 44);
            [self.itemLayoutAttributes addObject:layoutHeader];
            // 更新第一个 Item 的起始 y 坐标
            y += self.headerReferenceSize.height;
        } else if (indexPath.section == 6) {
            layoutHeader.frame = CGRectMake(0, y - self.minimumInteritemSpacing + 15, [UIScreen mainScreen].bounds.size.width, 52);
            [self.itemLayoutAttributes addObject:layoutHeader];
            // 更新第一个 Item 的起始 y 坐标
            y += self.headerReferenceSize.height + 15;
        }
    }
    frame = CGRectMake(x, y, size.width, size.height);
    // 加入 frame 池中，等待碰撞检测
    [self.framePool addObject:[NSValue valueWithCGRect:frame]];
    // 更新 contentSize, 此处赋值有时候不是最大值, 如果需要用到 collectionViewContentSize 这个属性, 需要判断新的值是否比原值大
    _contentSize.width = CGRectGetMaxX(frame) + self.sectionInset.right;
    _contentSize.height = CGRectGetMaxY(frame) + self.sectionInset.bottom;
    // 创建每个item对应的布局属性
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAttributes.frame = frame;
    
    return layoutAttributes;
}

// 重载返回所有布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemLayoutAttributes;
}

// item 碰撞检测 [判断 x 是否重叠]
- (CGRect)itemCollisionDetectionWithCurrentFrame:(CGRect)currentFrame {
    BOOL collision = false;
    CGRect frame = CGRectZero;
    for (NSValue *value in self.framePool) {
        frame = [value CGRectValue];
        // 判断两个区域是否重叠
        collision = CGRectContainsRect(frame, currentFrame);
        if (collision) { break; }
    }
    if (collision) {
        // 发生碰撞
        return CGRectMake(CGRectGetMaxX(frame) + self.minimumInteritemSpacing, CGRectGetMaxY(currentFrame), currentFrame.size.width, currentFrame.size.height);
    } else {
        // 没有碰撞
        return currentFrame;
    }
}

- (NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *)allLayoutAttributes {
    if (!_allLayoutAttributes) {
        _allLayoutAttributes = [NSMutableArray array];
    }
    return _allLayoutAttributes;
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)itemLayoutAttributes {
    if (!_itemLayoutAttributes) {
        _itemLayoutAttributes = [NSMutableArray array];
    }
    return _itemLayoutAttributes;
}

- (NSMutableArray *)framePool {
    if (!_framePool) {
        _framePool = [NSMutableArray array];
    }
    return _framePool;
}

@end
