//
//  AFHTTPSessionManager+JYHLHttpManager.m
//  JYHLLiveRoom
//
//  Created by Jiuyu on 2017/7/19.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "AFHTTPSessionManager+JYHLHttpManager.h"

@implementation AFHTTPSessionManager (JYHLHttpManager)


- (void)jy_httpMethod:(NSString *_Nonnull)method URLString:(NSString *_Nonnull)URLString parameters:(id _Nullable )parameters success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    [self requestWithMethod:method URLString:URLString parameters:parameters upProgress:nil downProgress:nil success:success failure:failure];
}





- (NSURLSessionDataTask *_Nullable)requestWithMethod:(NSString *_Nonnull)method URLString:(NSString *_Nonnull)URLString
                                          parameters:(id _Nullable )parameters
                                          upProgress:(nullable void (^)(NSProgress *_Nullable))uploadProgress
                                        downProgress:(nullable void (^)(NSProgress *_Nullable))downloadProgress
                                             success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    
   
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               if (failure) {
                                   failure(dataTask, error);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    [dataTask resume];
    
    return dataTask;

    
}
@end
