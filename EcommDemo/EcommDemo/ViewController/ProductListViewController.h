//
//  ProductListViewController.h
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category;
@interface ProductListViewController : UIViewController
@property (nonatomic, strong)Category *selectedCategory;
- (IBAction)sortButtonAction:(id)sender;
@end
