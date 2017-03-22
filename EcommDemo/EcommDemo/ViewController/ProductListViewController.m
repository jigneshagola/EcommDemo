//
//  ProductListViewController.m
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "ProductListViewController.h"

#import "ProductCollectionViewCell.h"

#import "Product.h"
#import "Category.h"
#import "Variant.h"

@interface ProductListViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *products;
@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.selectedCategory.name;
    self.products = [NSMutableArray new];

    for (NSArray *variants in [self.selectedCategory.products valueForKey:@"variants"]) {
        [self.products addObjectsFromArray:variants];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionViewCell" forIndexPath:indexPath];
    
    Variant *variant = self.products[indexPath.row];
    cell.labelProductName.text = variant.product.name;
    
    NSString *veriantString = @"";
    if(variant.color) {
        veriantString = [NSString stringWithFormat:@"Color : %@",variant.color];
    }
    
    if(variant.size) {
        veriantString = [NSString stringWithFormat:@"%@, Size : %@",veriantString,variant.size];
    }
    
    cell.labelVarientText.text = veriantString;
    cell.labelProductPrice.text = [NSString stringWithFormat:@"$%@",variant.price];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width/2 - 12,217);
}

- (IBAction)sortButtonAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sort Option" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    
    UIAlertAction *mostViewedAction = [UIAlertAction actionWithTitle:@"Most Viewed" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self sortWithSortKey:@"product.viewCount"];
    }];
    [alert addAction:mostViewedAction];
    
    UIAlertAction *mostOrderedAction = [UIAlertAction actionWithTitle:@"Most Ordered" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self sortWithSortKey:@"product.orderCount"];
    }];
    [alert addAction:mostOrderedAction];
    
    UIAlertAction *mostSharedAction = [UIAlertAction actionWithTitle:@"Most Shared" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self sortWithSortKey:@"product.sharedCount"];
    }];
    [alert addAction:mostSharedAction];
    
    [self presentViewController:alert animated:true completion:^{}];
}

- (void)sortWithSortKey:(NSString *)sortKey {
    
    NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
    self.products =  [[self.products sortedArrayUsingDescriptors:@[descriptor]] mutableCopy];
    [self.collectionView reloadData];
}
@end
