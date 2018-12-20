//
//  AFHTTPSessionManager+JYHLHttpManager.h
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/7/19.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (JYHLHttpManager)

- (void)jy_httpMethod:(NSString *_Nonnull)method URLString:(NSString *_Nonnull)URLString parameters:(id _Nullable )parameters success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

//- (NSURLSessionDataTask *_Nullable)requestWithMethod:(NSString *_Nonnull)method URLString:(NSString *_Nonnull)URLString
//                                 parameters:(id _Nullable )parameters
//                                   upProgress:(nullable void (^)(NSProgress *_Nullable))uploadProgress
//                                   downProgress:(nullable void (^)(NSProgress *_Nullable))downloadProgress
//                                    success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
//                                    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

@end
