//
//  CategoryMapper.m
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "CategoryMapper.h"
#import "Category.h"

@interface CategoryMapper () {
    NSMutableArray *allCategorisArray;
}
@property (nonatomic,strong) NSMutableArray *rootCategorisArray;

@end

@implementation CategoryMapper

- (NSArray *)mapCategorisFromAllCategories:(NSArray *)allCategoris {
    
    allCategorisArray = [NSMutableArray new];
    self.rootCategorisArray = [NSMutableArray new];
    
    //Find Categoris with no child
    NSPredicate *noChildPredicate = [NSPredicate predicateWithFormat:@"child_categories == %@",@[]];
    NSArray *categoryWithNoChild = [allCategoris filteredArrayUsingPredicate:noChildPredicate];
    
    for (NSDictionary *categoryDict in categoryWithNoChild) {
        
        //Create object of category with no child (i.e. category with product)
        Category *category = [[Category alloc] initWithDict:categoryDict];
        [allCategorisArray addObject:category];
        
        [self findParentAndMapToChildCategory:category FromDataArray:allCategoris];
    }
    
    return [NSArray arrayWithArray:self.rootCategorisArray];

}

- (void)findParentAndMapToChildCategory:(Category *)category FromDataArray:(NSArray *)categoryArray {
    
    //Search for parent of category
    Category *parentCategory = [self getParentCategoryForChildCategory:category fromArray:categoryArray];
    if (parentCategory != nil) {
        if(![parentCategory.childCategory containsObject:category]) {
            [parentCategory.childCategory addObject:category];
        }
        //Search grand parent by calling same function
        [self findParentAndMapToChildCategory:parentCategory FromDataArray:categoryArray];
    } else {
        //If there are no parent it's a root category
        if(![self.rootCategorisArray containsObject:category]) {
            [self.rootCategorisArray addObject:category];
        }
        return;
    }
}

- (Category *)getParentCategoryForChildCategory:(Category *)category fromArray:(NSArray *)categoryArray {
    
    //iterate in all categoris and find parent category return nil if it has no parent
    
    for (NSDictionary *categoryDict in categoryArray) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self IN %@",@[category._id]];
        NSArray *categoris = [[categoryDict objectForKey:@"child_categories"] filteredArrayUsingPredicate:predicate];
        
        if(categoris.count) {
            //Check if category object already created
            NSArray *paretcategoris = [allCategorisArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"_id == %@",categoryDict[@"id"]]];
            if (paretcategoris.count == 1) {
                return paretcategoris.lastObject;
            } else {
                //If object is not created creat it
                Category *category = [[Category alloc] initWithDict:categoryDict];
                [allCategorisArray addObject:category];
                return category;
            }
        }
    }
    return nil;
}

- (NSMutableArray *)getAllCategoris {
    return allCategorisArray;
}
@end
