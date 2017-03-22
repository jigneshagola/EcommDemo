//
//  Rank.m
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "RankMapper.h"
#import "NSDictionary+NSNullNull.h"
#import "Category.h"
#import "Product.h"

#define RANK_TYPE_MOST_VIEWED @"Most Viewed Products"
#define RANK_TYPE_MOST_ORDERED @"Most OrdeRed Products"
#define RANK_TYPE_SHARED_PRODUCT @"Most ShaRed Products"
@interface RankMapper()

@property (nonatomic,strong) NSMutableArray *allProducts;

@end

@implementation RankMapper

- (void)MapRank:(NSArray *)rankArray toCategoryProduct:(NSArray *)categoryArray {
    
    [self setAllProductsFromCategoryArray:categoryArray];
    
    for (NSDictionary *rankDict in rankArray) {
        NSString *rankType = [rankDict getNilOrobjectForKey:@"ranking"];
        if ([rankType isEqualToString:RANK_TYPE_MOST_VIEWED]) {
            NSArray *rankProduct = [rankDict getNilOrobjectForKey:@"products"];
            for (NSDictionary *rankMapObject in rankProduct) {
                NSArray *products = [self.allProducts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"_id == %@",[rankMapObject getNilOrobjectForKey:@"id"]]];
                if (products.count) {
                    Product *product = [products lastObject];
                    product.viewCount = [rankMapObject getNilOrobjectForKey:@"view_count"];
                }
            }
        }
        else if ([rankType isEqualToString:RANK_TYPE_MOST_ORDERED]) {
            NSArray *rankProduct = [rankDict getNilOrobjectForKey:@"products"];
            for (NSDictionary *rankMapObject in rankProduct) {
                NSArray *products = [self.allProducts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"_id == %@",[rankMapObject getNilOrobjectForKey:@"id"]]];
                if (products.count) {
                    Product *product = [products lastObject];
                    product.orderCount = [rankMapObject getNilOrobjectForKey:@"order_count"];
                }
            }
        }
        else if ([rankType isEqualToString:RANK_TYPE_SHARED_PRODUCT]) {
            NSArray *rankProduct = [rankDict getNilOrobjectForKey:@"products"];
            for (NSDictionary *rankMapObject in rankProduct) {
                NSArray *products = [self.allProducts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"_id == %@",[rankMapObject getNilOrobjectForKey:@"id"]]];
                if (products.count) {
                    Product *product = [products lastObject];
                    product.sharedCount = [rankMapObject getNilOrobjectForKey:@"shares"];
                }
            }
        }
    }
}

- (void)setAllProductsFromCategoryArray:(NSArray *)allCategory {
    self.allProducts = [NSMutableArray new];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"products != %@",@[]];
    NSArray *categoryWithProducts = [allCategory filteredArrayUsingPredicate:predicate];
    
    for (NSArray *productArray  in [categoryWithProducts valueForKeyPath:@"products"]) {
        [self.allProducts addObjectsFromArray:productArray];
    }
    
}
@end
