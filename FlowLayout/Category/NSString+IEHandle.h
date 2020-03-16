//
//  NSString+IEHandle.h
//  i_ExhibitionPublic
//
//  NSString 处理分类
//
//  Created by ShevaKuilin on 2019/9/17.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (IEHandle)

/** Unicode 解码
 *
 */
- (NSString *)unicodeString;

/** 计算文本宽度
 *
 * @param content    字符串内容
 * @param font           字体
 *
 */
+ (CGFloat)widthForString:(NSString *)content
                     font:(UIFont *)font;

/** 计算文本高度
 *
 * @param content    字符串内容
 * @param font           字体
 *
*/
+ (CGFloat)heightForString:(NSString *)content
                      font:(UIFont *)font;

/** 图文混排
 *
 * @param bounds              图片 bounds
 * @param image                插入的图片
 * @param insertIndex   图片插入的位置
 *
 */
- (NSAttributedString *)photoTextWithBounds:(CGRect)bounds
                                      image:(UIImage *)image
                                insertIndex:(NSUInteger)insertIndex;

/** 高亮富文本
 *
 * @param content                     高亮文本
 * @param highLightColor     高亮颜色
 *
 */
- (NSAttributedString *)highLightContent:(NSString *)content
                          highLightColor:(UIColor *)highLightColor;

/** 改变金额小数字体尺寸
 *
 * @param content    被改变文本
 * @param fontFont  被改变的字体尺寸
 *
 */
- (NSAttributedString *)sizeChangeContent:(NSString *)content
                                 fontFont:(UIFont *)fontFont;

/** 剥离小数
 *
 * @param content 原始文本
 *
 */
+ (NSString *)stripDecimal:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
