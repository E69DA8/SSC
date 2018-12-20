//
//  NSObject+path.h
//  DownLoadData
//
//  Created by 任永乐 on 16/8/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)
- (NSString *)r_filePath;

+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
