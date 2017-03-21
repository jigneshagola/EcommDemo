//
//  NetworkManager.m
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "NetworkManager.h"


@implementation NetworkManager

- (id)init {
    self = [super init];
    
    if (self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] init];
    }
    return self;
}

- (void)getWithUrl:(NSString *)url param:(id)param CompletionHandler:(void(^)(id response,NSError *error))completion {
    
    [self.sessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response for Url : %@ \n Response Data : \n%@",url,responseObject);
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error for Url : %@ \n Error : \n%@",url,error);
        completion(nil,error);
    }];
}
@end
