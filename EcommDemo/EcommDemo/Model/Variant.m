//
//  Variant.m
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "Variant.h"
#import "NSDictionary+NSNullNull.h"
@implementation Variant

- (id)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        self._id = [dict getNilOrobjectForKey:@"id"];
        self.color = [dict getNilOrobjectForKey:@"color"];
        self.size = [dict getNilOrobjectForKey:@"size"];
        self.price = [dict getNilOrobjectForKey:@"price"];
    }
    return self;
}
@end
