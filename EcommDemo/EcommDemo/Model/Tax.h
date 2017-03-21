//
//  Tax.h
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tax : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSNumber *value;

- (id)initWithDict:(NSDictionary *)dict;
@end
