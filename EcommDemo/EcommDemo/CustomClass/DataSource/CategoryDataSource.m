//
//  CategoryDataSource.m
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "CategoryDataSource.h"

@implementation CategoryDataSource

- (id)initWithCategory:(Category *)category {
    self = [super init];
    if(self) {
        self.openRowDataSource = [NSMutableArray new];
        self.category = category;
        self.lastChildOpenIndex = -1;
        self.isSelected = false;
    }
    return self;
}

@end
