//
//  Tax.m
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "Tax.h"
#import "NSDictionary+NSNullNull.h"

@implementation Tax
- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = [dict getNilOrobjectForKey:@"name"];
        self.value = [dict getNilOrobjectForKey:@"value"];
    }
    
    return self;
}
@end
