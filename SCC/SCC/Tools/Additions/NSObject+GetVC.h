//
//  NSObject+GetVC.h
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/10/9.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GetVC)

/**
 获取当前屏幕显示的 ViewController

 */
- (UIViewController *)getCurrentVC;

- (UIViewController *)getPopCurrentVC;

- (void)findNavigationControllerWithCompletionCallBack:(void(^)())callBack;

@end
