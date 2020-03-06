//
//  ViewController.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/2/27.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "MyFootView.h"
#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "ElementAttributes.h"
#import "MyCollectionViewCell.h"
#import "SKCollectionViewFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<ElementAttributes *> *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化模拟数据
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 17; i++) {
        ElementAttributes *attributes = [ElementAttributes new];
        attributes.cornerRadius = 4;
        attributes.title = [NSString stringWithFormat:@"第%ld位", (long)i];
        attributes.contentText = @"点击查看详情";
        if (i == 0) {
            attributes.themeColor = [UIColor colorWithRed:186/255.0 green:230/255.0  blue:55/255.0  alpha:1.0];
        } else if (i == 1) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:133/255.0  blue:192/255.0  alpha:1.0];
        } else if (i == 2 || i == 3) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:214/255.0  blue:100/255.0  alpha:1.0];
        } else if (i == 4) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:156/255.0  blue:111/255.0  alpha:1.0];
        } else if (i == 5) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:156/255.0  blue:111/255.0  alpha:1.0];
        } else if (i == 6) {
            attributes.themeColor = [UIColor colorWithRed:250/255.0 green:219/255.0  blue:19/255.0  alpha:1.0];
        } else if (i == 7) {
            attributes.themeColor = [UIColor colorWithRed:186/255.0 green:230/255.0  blue:55/255.0  alpha:1.0];
        } else if (i == 8) {
            attributes.themeColor = [UIColor colorWithRed:93/255.0 green:219/255.0  blue:211/255.0  alpha:1.0];
        } else if (i == 9) {
            attributes.themeColor = [UIColor colorWithRed:250/255.0 green:219/255.0  blue:19/255.0  alpha:1.0];
        } else if (i == 10) {
            attributes.themeColor = [UIColor colorWithRed:179/255.0 green:127/255.0  blue:235/255.0  alpha:1.0];
        } else if (i == 11) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:214/255.0  blue:100/255.0  alpha:1.0];
        } else if (i == 12) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:133/255.0  blue:192/255.0  alpha:1.0];
        } else if (i == 13) {
            attributes.themeColor = [UIColor colorWithRed:186/255.0 green:230/255.0  blue:55/255.0  alpha:1.0];
        } else if (i == 14) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:120/255.0  blue:116/255.0  alpha:1.0];
        } else if (i == 15) {
            attributes.themeColor = [UIColor colorWithRed:255/255.0 green:219/255.0  blue:19/255.0  alpha:1.0];
        } else if (i == 16) {
            attributes.themeColor = [UIColor colorWithRed:93/255.0 green:219/255.0 blue:211/255.0 alpha:1.0];
        }
        [self.dataArray addObject:attributes];
    }
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return _dataArray.count;
    } else if (section == 2) {
        return 10;
    } else {
        return 4;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"1" forIndexPath:indexPath];
    cell.attributes = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionFooter) {
        MyFootView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor orangeColor];
        return footerview;
    }

    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击到第%ld位", (long)indexPath.row);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(collectionView.frame.size.width, 50);
//}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row < 2) {
            return CGSizeMake(168.5, 75);
        } else if (indexPath.row == 2) {
            return CGSizeMake(109.5, 158);
        } else if (indexPath.row > 2 && indexPath.row < 7) {
            return CGSizeMake(109.5, 75);
        } else if (indexPath.row == 7) {
            return CGSizeMake(345, 75);
        } else if (indexPath.row > 9 && indexPath.row < 13) {
            return CGSizeMake(109.5, 75);
        } else {
            return CGSizeMake(168.5, 75);
        }
    } else if (indexPath.section == 2) {
        return CGSizeMake((self.view.frame.size.width - 62)/5, 85);
    } else {
        return CGSizeMake((self.view.frame.size.width - 56)/4, 60);
    }
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    } else if (section == 1) {
//        return 8;
//    } else {
//        return 18.5;
//    }
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if (section == 0) {
//        return 30;
//    } else if (section == 1) {
//        return 8;
//    } else {
//        return 16;
//    }
//}

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        SKCollectionViewFlowLayout *layout = [[SKCollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width - 30, 30);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"1"];
        [_collectionView registerClass:[MyFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}

@end
