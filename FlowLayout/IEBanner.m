//
//  IEBanner.m
//  i_ExhibitionPublic
//
//  Created by ShevaKuilin on 2019/11/19.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import "IEBanner.h"

@implementation IEBanner

#pragma mark - 字段映射

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"bannerId": @"id",
        @"pushType":@"urlType",
        @"argument":@"url"
    };
}

@end
