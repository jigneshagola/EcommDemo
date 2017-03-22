//
//  CategoryViewController.m
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "CategoryViewController.h"
#import "ProductListViewController.h"
#import "NetworkManager.h"
#import "NSDictionary+NSNullNull.h"

#import "Category.h"
#import "CategoryMapper.h"

#import "CatagoryTableViewDataSource.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "RankMapper.h"

#define PRODUCT_LIST_SEGUE @"productListSegue"

@interface CategoryViewController ()<BasicCategoruSelectionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *categoris;

@property (nonatomic,strong) CatagoryTableViewDataSource *tableViewDataSource;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
    self.tableViewDataSource  = [[CatagoryTableViewDataSource alloc]initWithCateogris:self.categoris];
    self.tableViewDataSource.delegate = self;
    
    self.tableView.delegate = self.tableViewDataSource;
    self.tableView.dataSource = self.tableViewDataSource;
    
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fetchData {
    NetworkManager *manager = [[NetworkManager alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    [manager getWithUrl:@"https://stark-spire-93433.herokuapp.com/json" param:nil CompletionHandler:^(id response, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:true];
        if (error) {
        } else {
            [self parseData:response];
            NSLog(@"Response");
        }
    }];
}

- (void)parseData:(NSDictionary *)dataDict {
    
    NSArray *categoryArray = [dataDict getNilOrobjectForKey:@"categories"];
    NSArray *rankArray = [dataDict getNilOrobjectForKey:@"rankings"];
    
    CategoryMapper *mapper = [[CategoryMapper alloc] init];
    self.categoris = [mapper mapCategorisFromAllCategories:categoryArray];
    
    RankMapper *rankMapper = [[RankMapper alloc] init];
    [rankMapper MapRank:rankArray toCategoryProduct:[mapper getAllCategoris]];
    
    self.tableViewDataSource.categoryTableView = self.tableView;
    
    [self.tableViewDataSource makeDataSource:self.categoris];
    [self.tableView reloadData];
}

- (void)categorySelected:(Category *)category {
    [self performSegueWithIdentifier:@"productListSegue" sender:category];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([PRODUCT_LIST_SEGUE isEqualToString:segue.identifier]) {
        ProductListViewController *productListViewController = [segue destinationViewController];
        productListViewController.selectedCategory = sender;
    }
}
@end
