//
//  Category.m
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "Category.h"
#import "NSDictionary+NSNullNull.h"
#import "Product.h"

@implementation Category
- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self._id = [dict getNilOrobjectForKey:@"id"];
        self.name = [dict getNilOrobjectForKey:@"name"];
        
        NSArray *productArray  = [dict getNilOrobjectForKey:@"products"];
        self.products = [NSMutableArray new];
        
        for (NSDictionary *productDict in productArray) {
            Product *product = [[Product alloc] initWithDict:productDict];
            [self.products addObject:product];
        }
        
        self.childCategory = [NSMutableArray new];
    }
    
    return self;
}
@end
