//
//  NSObject+CZRuntime.h
//
//  Created by 刘凡 on 2016/09/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CZRuntime)

/**
 使用字典数组创建当前类对象的数组

 @param array 字典数组

 @return 当前类对象的数组
 */
+ (NSArray *)cz_objectsWithArray:(NSArray *)array;

/**
 返回当前类的属性数组

 @return 属性数组
 */
+ (NSArray *)cz_propertiesList;

/**
 返回当前类的成员变量数组

 @return 成员变量数组
 */
+ (NSArray *)cz_ivarsList;

/**
 返回当前类的方法数组

 @return 方法数组
 */
+ (NSArray *)cz_methodList;

/**
 返回当前类的协议数组

 @return 协议数组
 */
+ (NSArray *)cz_protocolList;

@end
