//
//  CategoryViewController.m
//  EcommDemo
//
//  Created by craftsvilla on 21/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "CategoryViewController.h"
#import "NetworkManager.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fetchData {
    NetworkManager *manager = [[NetworkManager alloc] init];
    [manager getWithUrl:@"https://stark-spire-93433.herokuapp.com/json" param:nil CompletionHandler:^(id response, NSError *error) {
        if (error) {
        
        } else {
            NSLog(@"Response");
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
