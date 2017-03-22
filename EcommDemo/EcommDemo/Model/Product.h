//
//  Product.h
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Tax;
@interface Product : NSObject

@property (nonatomic,strong) NSNumber *_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *date_added;

@property (nonatomic,strong) NSMutableArray *variants;
@property (nonatomic,strong) Tax *tax;

@property (nonatomic,strong) NSNumber *viewCount;
@property (nonatomic,strong) NSNumber *orderCount;
@property (nonatomic,strong) NSNumber *sharedCount;

- (id)initWithDict:(NSDictionary *)dict;

@end
