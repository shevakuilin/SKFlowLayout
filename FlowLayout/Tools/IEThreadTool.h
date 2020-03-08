//
//  IEThreadTool.h
//  i_ExhibitionPublic
//
//  多线程工具
//
//  Created by ShevaKuilin on 2019/9/25.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DispatchTimerHandler)(void);
typedef void (^DispatchMainThreadHandler)(void);
typedef void (^DispatchOnceHandler)(void);
typedef void (^DispatchAfterHandler)(void);

@interface IEThreadTool : NSObject

/** GCD 获取一个全新 Timer
 *
 */
+ (id)gcd_timer;

/** 开启一个 GCD 定时器
 *
 * @param timer                    定时 Timer
 * @param delayTime           延迟执行时间
 * @param timeInterval    执行间隔时间
 * @param handler               执行任务
 *
 */
+ (void)gcd_dispatchTimer:(id)timer delayTime:(NSTimeInterval)delayTime timeInterval:(NSTimeInterval)timeInterval handler:(DispatchTimerHandler)handler;

/** 暂停指定 GCD 定时任务
 *
 * @param timer     指定的定时任务
 *
 */
+ (void)gcd_dispatchSuspendTask:(dispatch_source_t)timer;

/** 恢复/开启指定 GCD 定时任务
 *
 * @param timer     指定的定时任务
 *
 */
+ (void)gcd_dispatchResumeTask:(dispatch_source_t)timer;

/** 取消指定 GCD 定时任务
 *
 * @param timer     指定的定时任务
 *
*/
+ (void)gcd_dispatchCancelTagk:(dispatch_source_t)timer;

/** GCD 返回主线程
 *
 */
+ (void)gcd_dispatchMainThread:(DispatchMainThreadHandler)handler;

/** GCD 创建单例
 *
 * @param onceToken once_t 变量标识
 *
 */
//+ (void)gcd_dispatchOnce:(dispatch_once_t)onceToken handler:(DispatchOnceHandler)handler;

/** GCD 延迟执行
 *
 * @param delaySeconds  延迟时间间隔
 *
 */
+ (void)gcd_dispatchAfter:(int64_t)delaySeconds handler:(DispatchAfterHandler)handler;

@end

NS_ASSUME_NONNULL_END
