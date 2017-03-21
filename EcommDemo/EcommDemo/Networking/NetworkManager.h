//
//  NetworkManager.h
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@interface NetworkManager : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

-(id)init;
- (void)getWithUrl:(NSString *)url param:(id)param CompletionHandler:(void(^)(id response,NSError *error))completion;
@end
