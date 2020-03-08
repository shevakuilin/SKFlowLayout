//
//  IEHomeBannerView.m
//  i_ExhibitionPublic
//
//  Created by ShevaKuilin on 2019/9/25.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import "IEBanner.h"
#import <Masonry.h>
#import "IEThreadTool.h"
//#import "IEConfigRouter.h"
#import "IEHomeBannerView.h"
#import "IEHomeBannerScrollProgressView.h"
#import "IEHomeBannerCollectionViewCell.h"

static NSString *const REUSEID_BANNER = @"REUSEID_BANNER";

@interface IEHomeBannerView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    NSInteger _currentIndex;
    CGFloat _dragStartX;
    CGFloat _dragEndX;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IEHomeBannerScrollProgressView *scrollProgressView;
@property (nonatomic, assign) CGFloat autoScrollCount;
@property (nonatomic, assign) BOOL reverseScroll;
@property (nonatomic, strong) dispatch_source_t bannerTimer;

@end

@implementation IEHomeBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initElements];
        [self registerCell];
    }
    return self;
}

- (void)initElements {
    self.backgroundColor = [UIColor clearColor];
    
    // 轮播容器
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 轮播进度
    self.scrollProgressView = [[IEHomeBannerScrollProgressView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.scrollProgressView];
    [self.scrollProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collectionView.mas_bottom).offset(-4);
        make.centerX.equalTo(self.collectionView.mas_centerX);
        make.height.offset(5);
        make.width.offset(0);
    }];
}

- (void)registerCell {
    [self.collectionView registerClass:[IEHomeBannerCollectionViewCell class] forCellWithReuseIdentifier:REUSEID_BANNER];
}

// Banner 自动循环滚动
- (void)autoCycleScrollBanner {
    if (!self.bannerTimer) {
        self.bannerTimer = [IEThreadTool gcd_timer];
    }
    @weakify(self)
    [IEThreadTool gcd_dispatchTimer:self.bannerTimer delayTime:5 timeInterval:5 handler:^{
        @strongify(self)
        // 确认循环滚动方向
        [self autoCycleDirection];
    }];
}

// 循环滚动方向
- (void)autoCycleDirection {
    @weakify(self)
    [IEThreadTool gcd_dispatchMainThread:^{
        @strongify(self)
        // 达到偏移量右边界，反向循环
        if (self.autoScrollCount == self.banners.count - 1) {
            self.reverseScroll = true;
        } else if (self.autoScrollCount == 0) { // 达到偏移量左边界，重置循环方向
            self.reverseScroll = false;
        }
        if (self.reverseScroll) {
            self.autoScrollCount -= 1;
        } else {
            self.autoScrollCount += 1;
        }
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.autoScrollCount inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//        [self.collectionView setContentOffset:CGPointMake(self.autoScrollCount * ScreenWidth, 0) animated:true];
    }];
}

// 暂停自动滚动
- (void)pauseAutoCycleScroll {
    // 暂停 Banner 定时任务
    [IEThreadTool gcd_dispatchSuspendTask:self.bannerTimer];
}

// 重启自动滚动
- (void)restartAutoCycleScroll {
    // 恢复 Banner 定时任务
    [IEThreadTool gcd_dispatchResumeTask:self.bannerTimer];
}

// 同步滚动计数
- (void)ayncScrollCount:(NSUInteger)index {
    self.autoScrollCount = index;
}

#pragma mark - Setter

- (void)setBanners:(NSArray<IEBanner *> *)banners {
    _banners = banners;
    // - Note: 自动滚动计数置零
    self.autoScrollCount = 0;
    // - Note: 取消当前定时任务
    [IEThreadTool gcd_dispatchCancelTagk:self.bannerTimer];
    // - Note: 初始化时 Timer 置空
    self.bannerTimer = nil;
    // 仅有一个 Banner 时，不显示滚动进度
    if (banners.count == 1) {
        self.scrollProgressView.hidden = true;
    } else {
        self.scrollProgressView.itemCount = _banners.count;
        CGFloat progressViewWidth = (_banners.count * 20) + ((_banners.count - 1) * 5);
        [self.scrollProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(progressViewWidth);
        }];
        // 创建单例，仅执行一次定时任务
//        static dispatch_once_t bannerToken;
//        @weakify(self)
//        [IEThreadTool gcd_dispatchOnce:bannerToken handler:^{
//            @strongify(self)
            // 开启 Banner 自动循环滚动
            [self autoCycleScrollBanner];
//        }];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // - Note: 默认提供一个占位
    return _banners.count > 0 ? _banners.count:1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IEHomeBannerCollectionViewCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSEID_BANNER forIndexPath:indexPath];
    // 设置 Banner 广告
    if (_banners.count > 0 && _banners.count > indexPath.row) {
        IEBanner *banner = [_banners objectAtIndex:indexPath.row];
        [bannerCell setBanner:banner.coverIcon];
    }
    
    return bannerCell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // - Todo: 点击 Banner 广告跳转
//    if ((_banners.count > 0 && _banners.count > indexPath.row)) {
//        IEBanner *banner = [_banners objectAtIndex:indexPath.row];
//        [IEConfigRouter routerDistributeWithPushType:banner.pushType argument:banner.argument];
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(ScreenWidth/* - 30*/, 148);
    return size;
}

#pragma mark - UICollectionViewDelegateFlowLayout

// 设置初始位置
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
//    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
//    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
//    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
//    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
//
//    return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width) / 2, 0, (collectionView.bounds.size.width - lastSize.width) / 2);
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 30;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSUInteger index = offsetX / ScreenWidth;
    // 同步圆点滚动进度
    [self.scrollProgressView syncScrollProgress:index];
}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    CGFloat offsetX = scrollView.contentOffset.x;
//    NSUInteger index = offsetX / ScreenWidth;
//    // 同步圆点滚动进度
//    [self.scrollProgressView syncScrollProgress:index];
//}

// 手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 暂停自动滚动
    [self pauseAutoCycleScroll];
    _dragStartX = scrollView.contentOffset.x;
}
 
// 手指拖动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

// 修复 cell 居中
- (void)fixCellToCenter {
    // 最小滚动距离
    float dragMiniDistance = self.bounds.size.width / 20.0f;
    if (_dragStartX - _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;// 向右
    }else if(_dragEndX - _dragStartX >= dragMiniDistance){
        _currentIndex += 1;// 向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    // 同步圆点滚动进度
    [self.scrollProgressView syncScrollProgress:_currentIndex];
    // 同步滚动计数
    [self ayncScrollCount:_currentIndex];
    // 重启 Banner 自动滚动
    [self restartAutoCycleScroll];
}

@end
