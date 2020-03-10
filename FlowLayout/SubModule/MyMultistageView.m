//
//  MyMultistageView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/9.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "NodeModel.h"
#import "CategoryView.h"
#import "MyMultistageView.h"
#import "MultiLevelTableView.h"

@interface MyMultistageView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MultiLevelTableView *tableView;
@property (nonatomic, copy) NSArray *categories;

@end

@implementation MyMultistageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        self.categories = [NSArray array];
        self.categories = @[@"技术研讨会 Technology and Solut", @"Industry Collaboration", @"Design and Trend", @"Sustainability Issue"];
    }
    return self;
}

- (NSArray*)returnData{
    NSArray *list = @[@{@"parentID":@"", @"name":@"技术研讨会 Technology and Solut", @"ID":@"1"},
                      @{@"parentID":@"1", @"name":@"2020/03/11", @"ID":@"10"},
                      @{@"parentID":@"1", @"name":@"2020/03/12", @"ID":@"11"},
                      @{@"parentID":@"10", @"name":@"14:30-16:30", @"ID":@"100"},
                      @{@"parentID":@"11", @"name":@"09:00-12:00", @"ID":@"110"},
                      @{@"parentID":@"11", @"name":@"09:00-12:00", @"ID":@"111"},
                      @{@"parentID":@"111", @"name":@"物联网技术在纺织行业应用", @"ID":@"1110"},
                      @{@"parentID":@"111", @"name":@"科技材料引领时尚未来 - SYCORE-TEX黑科技让春装护寒冬", @"ID":@"1111"},
                      @{@"parentID":@"", @"name":@"Industry Collaboration", @"ID":@"2"},
                      @{@"parentID":@"2", @"name":@"2020/03/13", @"ID":@"20"},
                      @{@"parentID":@"20", @"name":@"13:30-15:00", @"ID":@"200"},
                      @{@"parentID":@"200", @"name":@"美丽诺羊毛产品创新", @"ID":@"2110"},
                    @{@"parentID":@"", @"name":@"Design and Trend", @"ID":@"3"},
                    @{@"parentID":@"3", @"name":@"2020/03/13", @"ID":@"30"},
                    @{@"parentID":@"30", @"name":@"13:30-15:00", @"ID":@"300"},
                    @{@"parentID":@"300", @"name":@"美丽诺羊毛产品创新", @"ID":@"3110"},
                    @{@"parentID":@"", @"name":@"Sustainability Issue", @"ID":@"4"},
                    @{@"parentID":@"4", @"name":@"2020/03/13", @"ID":@"40"},
                    @{@"parentID":@"40", @"name":@"13:30-15:00", @"ID":@"400"},
                    @{@"parentID":@"400", @"name":@"美丽诺羊毛产品创新", @"ID":@"4110"},];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in list) {
        NodeModel *node = [NodeModel nodeWithParentID:dic[@"parentID"]
                                                      name:dic[@"name"]
                                                childrenID:dic[@"ID"]
                                                  isExpand:NO];
        [array addObject:node];
    }
    
    return [array copy];
}

//#pragma mark - UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return _categories.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
//    }
//    return cell;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CategoryView *headerView = [[CategoryView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
//    headerView.categoryName = _categories[section];
//    headerView.backgroundColor = [UIColor whiteColor];
//
//    return headerView;
//}
//
//#pragma mark - UITableViewDataSource
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44;
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[MultiLevelTableView alloc] initWithFrame:CGRectZero nodes:[self returnData] rootNodeID:@"" needPreservation:true selectBlock:^(NodeModel * _Nonnull node) {
            
        }];
        _tableView.scrollEnabled = false;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.showsHorizontalScrollIndicator = false;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
