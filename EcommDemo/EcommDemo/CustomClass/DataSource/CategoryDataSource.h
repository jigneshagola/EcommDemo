//
//  CategoryDataSource.h
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"
@interface CategoryDataSource : NSObject

@property(nonatomic,strong)NSMutableArray *openRowDataSource;
@property(nonatomic,strong)Category *category;
@property(nonatomic,assign)BOOL isSelected;
@property (nonatomic,assign) NSInteger lastChildOpenIndex;

-(id)initWithCategory:(Category *)category;

@end
