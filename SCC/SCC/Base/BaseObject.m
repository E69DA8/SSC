//
//  BaseObject.m
//  消息转发
//
//  Created by zzz on 16/10/17.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

void nilMethod(id self,SEL sel){
    
    NSLog(@"unrecognized selector sent to instance");
}


@end
