//
//  NodeModel.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "NodeModel.h"

@implementation NodeModel

+ (instancetype)nodeWithParentID:(NSString *)parentID name:(NSString *)name childrenID:(NSString *)childrenID isExpand:(BOOL)bol{
    return [self nodeWithParentID:parentID name:name childrenID:childrenID level:-1 isExpand:bol];
}

+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID level:(NSUInteger)level isExpand:(BOOL)bol{
    
    NodeModel *node = [[NodeModel alloc] init];
    node.parentID = parentID;
    node.name = name;
    node.childrenID = childrenID;
    node.level = level;
    node.expand = bol;
    
    return node;
}

@end
