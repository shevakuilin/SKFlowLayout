//
//  ViewController.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/2/27.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "MySearchBar.h"
#import "MyHeaderView.h"
#import "MyBannerView.h"
#import "MyMessageView.h"
#import "SKGradientView.h"
#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "MyMultistageView.h"
#import "ElementAttributes.h"
#import "MyCollectionViewCell.h"
#import "SKCollectionViewFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<ElementAttributes *> *dataArray;
@property (nonatomic, assign) CGFloat lastSectionHeight;
@property (nonatomic, strong) SKGradientView *gradientView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置梯度渐变
    [self.view addSubview:self.gradientView];
    
    // 初始化模拟数据
    self.lastSectionHeight = 176;
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
    
    // 注册通知更新会议日程高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSectionHeight:) name:@"updateHeight" object:nil];
}

- (void)updateSectionHeight:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    if (userInfo) {
        NSString *status = userInfo[@"isExpand"];
        NSNumber *value = userInfo[@"height"];
        CGFloat height = [value floatValue];
        if ([status isEqualToString:@"add"]) {
            self.lastSectionHeight = self.lastSectionHeight + height;
        } else {
            self.lastSectionHeight = self.lastSectionHeight - height;
        }
        NSLog(@"section高度 = %.2f", self.lastSectionHeight);
        // 参考：https://stackoverflow.com/questions/13272315/uicollectionview-animate-data-change
        [self.collectionView performBatchUpdates:^{
            [self.collectionView reloadData];
        } completion:^(BOOL finished) {
            // do something on completion
            NSLog(@"点击位置 = %ld", (long)index);
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:6] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:true];
        }];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 7;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0 || section == 2 || section == 4) {
        return 1;
    } else if (section == 1) {
        return 4;
    } else if (section == 3) {
        return 10;
    } else if (section == 6){
        return 1;
    } else {
        return _dataArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MySearchBar *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"0" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        MyBannerView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"2" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 4) {
        MyMessageView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"3" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 6){
        MyMultistageView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"4" forIndexPath:indexPath];
        return cell;
    } else {
        MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"1" forIndexPath:indexPath];
        cell.attributes = [_dataArray objectAtIndex:indexPath.row];
        
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        MyHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        if (indexPath.section == 6) {
            headerView.title = @"会议日程";
        }
        return headerView;
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
    NSInteger section = indexPath.section;
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width - 30, 63);
    } else if (section == 1) {
        return CGSizeMake((self.view.frame.size.width - 56)/4, 60);
    } else if (section == 2) {
        return CGSizeMake(self.view.frame.size.width, 140.5);
    } else if (section == 3) {
        return CGSizeMake((self.view.frame.size.width - 62)/5, 85);
    } else if (section == 4) {
        return CGSizeMake(self.view.frame.size.width, 60);
    } else if (section == 6) {
        return CGSizeMake(self.view.frame.size.width, self.lastSectionHeight);
    } else {
        if (indexPath.row < 2) {
            return CGSizeMake(/*168.5*/(ScreenWidth - 38)/2, /*75*/((ScreenWidth - 38)/2) / 2.25);
        } else if (indexPath.row == 2) {
            return CGSizeMake(/*109.5*/(ScreenWidth - 46)/3.004, /*158*/((ScreenWidth - 46)/3.004) / 0.69);
        } else if (indexPath.row > 2 && indexPath.row < 7) {
            return CGSizeMake(/*109.5*/(ScreenWidth - 46)/3.004, /*75*/((ScreenWidth - 46)/3.004) / 1.46);
        } else if (indexPath.row == 7) {
            return CGSizeMake(/*345*/ScreenWidth - 30, /*75*/(ScreenWidth - 30) / 4.6);
        } else if (indexPath.row > 9 && indexPath.row < 13) {
            return CGSizeMake(/*109.5*/(ScreenWidth - 46)/3.004, /*75*/((ScreenWidth - 46)/3.004) / 1.46);
        } else {
            return CGSizeMake(/*168.5*/(ScreenWidth - 38)/2, /*75*/((ScreenWidth - 38)/2) / 2.25);
        }
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    self.gradientView.frame = CGRectMake(self.gradientView.frame.origin.x, self.gradientView.frame.origin.x - offsetY, self.gradientView.frame.size.width, self.gradientView.frame.size.height);
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        SKCollectionViewFlowLayout *layout = [[SKCollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 44);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[MySearchBar class] forCellWithReuseIdentifier:@"0"];
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"1"];
        [_collectionView registerClass:[MyBannerView class] forCellWithReuseIdentifier:@"2"];
        [_collectionView registerClass:[MyMessageView class] forCellWithReuseIdentifier:@"3"];
        [_collectionView registerClass:[MyMultistageView class] forCellWithReuseIdentifier:@"4"];
        [_collectionView registerClass:[MyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}

- (SKGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[SKGradientView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 265)];
    }
    return _gradientView;
}

@end
