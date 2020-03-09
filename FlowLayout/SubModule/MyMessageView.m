//
//  MyMessageView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/8.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import <Masonry.h>
#import "MyMessageView.h"

@implementation MyMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ColorRGB(245, 246, 250);
        
        UIView *messageView = [UIView new];
        messageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:messageView];
        [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(8, 0, 8, 0));
        }];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"消息 |";
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        titleLabel.textColor = Color16Hex(0x424242);
        [messageView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(messageView);
            make.left.equalTo(messageView).offset(15);
            make.width.offset(40);
        }];
        
        UILabel *messageLabel = [UILabel new];
        messageLabel.text = @"您发送商脉圈审核通过！";
        messageLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        messageLabel.textColor = Color16Hex(0x6E7580);
        [messageView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(messageView);
            make.left.equalTo(titleLabel.mas_right).offset(4);
            make.right.equalTo(messageView).offset(-15);
        }];
    }
    return self;
}

@end
