//
//  Variant.h
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
@interface Variant : NSObject
@property (nonatomic,strong) NSNumber *_id;
@property (nonatomic,strong) NSString *color;
@property (nonatomic,strong) NSNumber *size;
@property (nonatomic,strong) NSNumber *price;
@property (nonatomic,strong) Product *product;

- (id)initWithDict:(NSDictionary *)dict;
@end
