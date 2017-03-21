//
//  Product.m
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "Product.h"
#import "NSDictionary+NSNullNull.h"
#import "Variant.h"

@implementation Product

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self._id = [dict getNilOrobjectForKey:@"id"];
        self.name = [dict getNilOrobjectForKey:@"name"];
        self.date_added = [dict getNilOrobjectForKey:@"date_added"];
        
        NSArray *variantArray = [dict getNilOrobjectForKey:@"variants"];
        self.variants = [NSMutableArray new];
        
        for (NSDictionary *variantDict in variantArray) {
            Variant *variant = [[Variant alloc] initWithDict:variantDict];
            [self.variants addObject:variant];
        }
    }
    return self;
}
@end
