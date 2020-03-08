//
//  IEThreadTool.m
//  i_ExhibitionPublic
//
//  Created by ShevaKuilin on 2019/9/25.
//  Copyright © 2019 北京昆仑亿发科技股份有限公司. All rights reserved.
//

#import "IEThreadTool.h"

@implementation IEThreadTool

#pragma mark - 获取一个全新 Timer

+ (id)gcd_timer {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    return timer;
}

#pragma mark - 开启一个 GCD 定时器

+ (void)gcd_dispatchTimer:(id)timer delayTime:(NSTimeInterval)delayTime timeInterval:(NSTimeInterval)timeInterval handler:(DispatchTimerHandler)handler {
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    dispatch_source_set_timer(timer, startDelayTime, (uint64_t)(timeInterval * NSEC_PER_SEC), 0);
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        if (handler) {
            handler();
        }
    });
    // 启动定时器
    [self gcd_dispatchResumeTask:timer];
}

#pragma mark - 暂停指定 GCD 定时任务

+ (void)gcd_dispatchSuspendTask:(dispatch_source_t)timer {
    if (timer) {
        dispatch_suspend(timer);
    }
}

#pragma mark - 恢复/开启指定 GCD 定时任务

+ (void)gcd_dispatchResumeTask:(dispatch_source_t)timer {
    if (timer) {
        dispatch_resume(timer);
    }
}

#pragma mark - 取消指定 GCD 定时任务

+ (void)gcd_dispatchCancelTagk:(dispatch_source_t)timer {
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

#pragma mark - GCD 返回主线程

+ (void)gcd_dispatchMainThread:(DispatchMainThreadHandler)handler {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (handler) {
            handler();
        }
    });
}

#pragma mark - GCD 创建单例

//+ (void)gcd_dispatchOnce:(dispatch_once_t)onceToken handler:(DispatchOnceHandler)handler {
//    dispatch_once(&onceToken, ^{
//        if (handler) {
//            handler();
//        }
//    });
//}

#pragma mark - GCD 延迟执行

+ (void)gcd_dispatchAfter:(int64_t)delaySeconds handler:(DispatchAfterHandler)handler {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (handler) {
            handler();
        }
    });
}

@end
