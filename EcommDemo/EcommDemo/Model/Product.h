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
@property (nonatomic,strong) NSMutableArray *variants;
@property (nonatomic,strong) NSString *date_added;
@property (nonatomic,strong) Tax *tax;

- (id)initWithDict:(NSDictionary *)dict;

@end
