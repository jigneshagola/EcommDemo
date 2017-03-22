//
//  CategoryMapper.h
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryMapper : NSObject
- (NSArray *)mapCategorisFromAllCategories:(NSArray *)allCategoris;
- (NSMutableArray *)getAllCategoris;
@end
