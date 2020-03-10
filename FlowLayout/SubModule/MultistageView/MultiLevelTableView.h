//
//  MultiLevelTableView.h
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

@class NodeModel;
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectBlock)(NodeModel *node);

@interface MultiLevelTableView : UITableView

- (id)initWithFrame:(CGRect)frame nodes:(NSArray*)nodes rootNodeID:(NSString*)rootID needPreservation:(BOOL)need selectBlock:(SelectBlock)block;

@end

NS_ASSUME_NONNULL_END
