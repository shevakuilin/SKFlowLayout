//
//  NodeModel.h
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NodeModel : NSObject

@property (nonatomic, strong) NSString *parentID;

@property (nonatomic, strong) NSString *childrenID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign, getter=isExpand) BOOL expand;


@property (nonatomic, assign) NSUInteger level;// depth in the tree sturct

@property (nonatomic, assign, getter=isLeaf) BOOL leaf;

@property (nonatomic, assign, getter=isRoot) BOOL root;

/**
 *  初始化节点
 *
 *  @param parentID parent node's ID
 *  @param name       node's name
 *  @param childrenID this node's ID
 *  @param level      depth in the tree
 *  @param bol        this node's child node is expand or not
 */
+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID level:(NSUInteger)level isExpand:(BOOL)bol;

+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID isExpand:(BOOL)bol;

@end

NS_ASSUME_NONNULL_END
