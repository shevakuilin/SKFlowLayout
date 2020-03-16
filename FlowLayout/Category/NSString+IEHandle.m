//
//  NSString+IEHandle.m
//  i_ExhibitionPublic
//
//  Created by ShevaKuilin on 2019/9/17.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import "NSString+IEHandle.h"

@implementation NSString (IEHandle)

#pragma mark - Unicode 解码

- (NSString *)unicodeString {
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSPropertyListFormat format = NSPropertyListOpenStepFormat;
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:&format error:nil];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

#pragma mark - 计算文本宽度

+ (CGFloat)widthForString:(NSString *)content
                     font:(UIFont *)font {
    CGSize size = [self sizeForString:content font:font];
    return size.width;
}

#pragma mark - 计算文本高度

+ (CGFloat)heightForString:(NSString *)content
                      font:(UIFont *)font {
    CGSize size = [self sizeForString:content font:font];
    return size.height;
}

+ (CGSize)sizeForString:(NSString *)value
                   font:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [value boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
}

#pragma mark - 图文混排

- (NSAttributedString *)photoTextWithBounds:(CGRect)bounds
                                      image:(UIImage *)image
                                insertIndex:(NSUInteger)insertIndex {
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", self]];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = bounds;
    attachment.image = image;
    NSAttributedString *icon = [NSAttributedString attributedStringWithAttachment:attachment];
    [placeholder insertAttributedString:icon atIndex:insertIndex];
    
    return placeholder;
}

#pragma mark - 高亮富文本

- (NSAttributedString *)highLightContent:(NSString *)content
                          highLightColor:(UIColor *)highLightColor {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attStr addAttributes:@{NSForegroundColorAttributeName:highLightColor} range:[self rangeOfString:content]];
    return attStr;
}

#pragma mark - 改变金额小数字体尺寸

- (NSAttributedString *)sizeChangeContent:(NSString *)content
                                 fontFont:(UIFont *)fontFont {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attStr addAttributes:@{NSFontAttributeName:fontFont} range:[self rangeOfString:content options:NSBackwardsSearch]];
    return attStr;
}

#pragma mark - 剥离小数

+ (NSString *)stripDecimal:(NSString *)content {
    NSArray *characters = [content componentsSeparatedByString:@"."];
    return characters.lastObject;
}

@end
