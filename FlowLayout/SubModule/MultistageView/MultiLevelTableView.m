//
//  MultiLevelTableView.m
//  FlowLayout
//
//  参考：https://www.jianshu.com/p/a040ff9e3ae3
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "DateCell.h"
#import "NodeModel.h"
#import "CategoryCell.h"
#import "ConferenceCell.h"
#import "MultiLevelTableView.h"

static CGFloat const cellHeight = 45.0;

@interface MultiLevelTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *rootID;
//all nodes
@property (nonatomic, copy) NSMutableArray *nodes;
//show the last status all child nodes keep when yes, or just show next level child nodes
@property (nonatomic, assign ,getter=isPreservation) BOOL preservation;
@property (nonatomic, strong) NSMutableArray *tempNodes;
@property (nonatomic, strong) NSMutableArray *reloadArray;
@property (nonatomic, copy) SelectBlock block;


@end

@implementation MultiLevelTableView

#pragma mark
#pragma mark life cycle
- (id)initWithFrame:(CGRect)frame nodes:(NSArray*)nodes rootNodeID:(NSString*)rootID needPreservation:(BOOL)need selectBlock:(SelectBlock)block{
    self = [self initWithFrame:frame];
    if (self) {
        self.rootID = rootID ?: @"";
        self.preservation = need;
        self.nodes = [nodes copy];
        self.block = [block copy];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tempNodes = [NSMutableArray array];
        _reloadArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark
#pragma mark set node's leaf and root propertys ,and level
- (void)setNodes:(NSMutableArray *)nodes{
    _nodes = nodes;

    [self judgeLeafAndRootNodes];
    [self updateNodesLevel];
    [self addFirstLoadNodes];
    [self reloadData];
}

- (void)addFirstLoadNodes{
    // add parent nodes on the upper level
    for (int i = 0 ; i<_nodes.count;i++) {
        NodeModel *node = _nodes[i];
        if (node.isRoot) {
            [_tempNodes addObject:node];
            
            if (node.isExpand) {
                [self expandNodesForParentID:node.childrenID insertIndex:[_tempNodes indexOfObject:node]];
            }
        }
    }
    [_reloadArray removeAllObjects];
}

//judge leaf node and root node
- (void)judgeLeafAndRootNodes{
    for (int i = 0 ; i<_nodes.count;i++) {
        NodeModel *node = _nodes[i];
        
        BOOL isLeaf = YES;
        BOOL isRoot = YES;
        for (NodeModel *tempNode in _nodes) {
            if ([tempNode.parentID isEqualToString:node.childrenID]) {
                isLeaf = NO;
            }
            if ([tempNode.childrenID isEqualToString:node.parentID]) {
                isRoot = NO;
            }
            if (!isRoot && !isLeaf) {
                break;
            }
        }
        node.leaf = isLeaf;
        node.root = isRoot;
    }
}

//set depath for all nodes
- (void)updateNodesLevel{
    [self setDepth:1 parentIDs:@[_rootID] childrenNodes:_nodes];
}

- (void)setDepth:(NSUInteger)level parentIDs:(NSArray*)parentIDs childrenNodes:(NSMutableArray*)childrenNodes {
    NSMutableArray *newParentIDs = [NSMutableArray array];
    NSMutableArray *leftNodes = [childrenNodes  mutableCopy];
    
    for (NodeModel *node in childrenNodes) {
        if ([parentIDs containsObject:node.parentID]) {
            node.level = level;
            [leftNodes removeObject:node];
            [newParentIDs addObject:node.childrenID];
        }
    }

    if (leftNodes.count>0) {
        level += 1;
        [self setDepth:level parentIDs:[newParentIDs copy] childrenNodes:leftNodes];
    }
}

#pragma mark
#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempNodes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NodeModel *node = [_tempNodes objectAtIndex:indexPath.row];
    if (node.parentID.length == 0) {
        return 44;
    } else if (node.parentID.length == 1) {
        return 32;
    }
    return 178;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    NodeModel *node = [_tempNodes objectAtIndex:indexPath.row];
    if (node.parentID.length == 0) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.rect = CGRectMake(0, 0, CGRectGetWidth(self.frame), 44);
        cell.node = node;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (node.parentID.length == 1) {
        DateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"date"];
        if (!cell) {
            cell = [[DateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"date"];
        }
        cell.dateStr = node.name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        ConferenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conference"];
        if (!cell) {
            cell = [[ConferenceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"conference"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeModel *currentNode = [_tempNodes objectAtIndex:indexPath.row];
    if (currentNode.isLeaf) {
        self.block(currentNode);
        return;
    } else {
        currentNode.expand = !currentNode.expand;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [_reloadArray removeAllObjects];
    
    if (currentNode.isExpand) {
        //expand
        [self expandNodesForParentID:currentNode.childrenID insertIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:_reloadArray withRowAnimation:UITableViewRowAnimationNone];
    }else{
        //fold
        [self foldNodesForLevel:currentNode.level currentIndex:indexPath.row];
         [tableView deleteRowsAtIndexPaths:_reloadArray withRowAnimation:UITableViewRowAnimationNone];
    }
    // - Note: 通知 collectionView 更新 section 高度
}

#pragma mark
#pragma mark fold and expand
- (void)foldNodesForLevel:(NSUInteger)level currentIndex:(NSUInteger)currentIndex {
    if (currentIndex+1<_tempNodes.count) {
        NSMutableArray *tempArr = [_tempNodes copy];
        for (NSUInteger i = currentIndex+1 ; i<tempArr.count;i++) {
            NodeModel *node = tempArr[i];
            if (node.level <= level) {
                break;
            }else{
                [_tempNodes removeObject:node];
                [_reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];//need reload nodes
            }
        }
    }
}

- (NSUInteger)expandNodesForParentID:(NSString*)parentID insertIndex:(NSUInteger)insertIndex {
    for (int i = 0 ; i<_nodes.count;i++) {
        NodeModel *node = _nodes[i];
        if ([node.parentID isEqualToString:parentID]) {
            if (!self.isPreservation) {
                node.expand = NO;
            }
            insertIndex++;
            [_tempNodes insertObject:node atIndex:insertIndex];
            [_reloadArray addObject:[NSIndexPath indexPathForRow:insertIndex inSection:0]];//need reload nodes
            
            if (node.isExpand) {
               insertIndex = [self expandNodesForParentID:node.childrenID insertIndex:insertIndex];
            }
        }
    }
    return insertIndex;
}

@end