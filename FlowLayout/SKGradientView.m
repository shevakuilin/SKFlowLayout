//
//  SKGradientView.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/16.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "SKGradientView.h"

@implementation SKGradientView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = @[(id)Color16Hex(0x13B6C9).CGColor,(id)Color16Hex(0x71D6C0).CGColor];
        gradient.startPoint = CGPointMake(0.5, 1);
        gradient.endPoint = CGPointMake(1, 0.5);
        //    gradient.locations = @[@(0.5f), @(1.0f)];
        [self.layer addSublayer:gradient];
        
    }
    return self;
}

@end
