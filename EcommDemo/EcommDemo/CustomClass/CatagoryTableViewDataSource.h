//
//  CatagoryTableViewDataSource.h
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HeaderView.h"

@class Category;

@protocol BasicCategoruSelectionDelegate <NSObject>
- (void)categorySelected:(Category *)category;
@end

@interface CatagoryTableViewDataSource : NSObject <UITableViewDataSource,UITableViewDelegate,TapActionDelegate>

@property (nonatomic,weak) id <BasicCategoruSelectionDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *categoryDataSource;
@property (nonatomic,strong) UITableView *categoryTableView;

- (id)initWithCateogris:(NSArray *)categoris;
- (void)makeDataSource:(NSArray *)categoris;
@end
