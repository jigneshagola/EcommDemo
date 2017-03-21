//
//  Category.h
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (nonatomic,strong) NSNumber *_id;
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSMutableArray *childCategory;
@property (nonatomic,strong) NSMutableArray *products;

@end
