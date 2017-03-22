//
//  CatagoryTableViewDataSource.m
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "CatagoryTableViewDataSource.h"
#import "HeaderView.h"
#import "Category.h"
#import "CategoryDataSource.h"
#import "CategoryTableViewCell.h"

@interface  CatagoryTableViewDataSource()
@property (nonatomic,assign) NSInteger currentSectionSelectedIndex;
@property (nonatomic,assign) NSInteger prevSectionSelectedIndex;
@end

@implementation CatagoryTableViewDataSource

- (id)initWithCateogris:(NSArray *)categoris {
    self = [super init];
    if (self) {
        self.currentSectionSelectedIndex = -1;
        self.prevSectionSelectedIndex = -1;
        self.categoryDataSource = [NSMutableArray new];
    }
    return self;
}

- (void)makeDataSource:(NSArray *)categoris {
    self.categoryTableView.tableFooterView = [UIView new];
    for (Category *category in categoris) {
        CategoryDataSource *categoryDataSource = [[CategoryDataSource alloc] initWithCategory:category];
        [self.categoryDataSource addObject:categoryDataSource];
    }
    
    [self.categoryTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categoryDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == self.currentSectionSelectedIndex) {
        CategoryDataSource *categoryDataSource = [self.categoryDataSource objectAtIndex:section];
        return categoryDataSource.openRowDataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDataSource *categoryDataSource = [self.categoryDataSource objectAtIndex:indexPath.section];
    CategoryDataSource *rowDataSource = [categoryDataSource.openRowDataSource objectAtIndex:indexPath.row];
    
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];

    cell.labelTitle.text = rowDataSource.category.name;
    
    if(rowDataSource.isSelected) {
        cell.buttonArraow.selected = true;
    } else {
        cell.buttonArraow.selected = false;
    }
    
    if (rowDataSource.category.products.count) {
        cell.buttonArraow.hidden = true;
    } else {
        cell.buttonArraow.hidden = false;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CategoryDataSource *categoryDataSource = [self.categoryDataSource objectAtIndex:section];
    
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44) andSection:section];
    headerView.labelTitle.text = categoryDataSource.category.name;
    headerView.delegate = self;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDataSource *sectionDataSource = [self.categoryDataSource objectAtIndex:indexPath.section];
    CategoryDataSource *rowDataSource = [sectionDataSource.openRowDataSource objectAtIndex:indexPath.row];
    
    if (rowDataSource.category.products.count) {
        [self.delegate categorySelected:rowDataSource.category];
        return;
    }
    
    NSInteger newIndex = 0;
    
    if (sectionDataSource.lastChildOpenIndex != -1 && sectionDataSource.lastChildOpenIndex != indexPath.row) {
        NSInteger prvSelectedIntex = sectionDataSource.lastChildOpenIndex;
        
        CategoryDataSource *prvDataSourceAtRow = [sectionDataSource.openRowDataSource objectAtIndex:sectionDataSource.lastChildOpenIndex];
        prvDataSourceAtRow.isSelected = !prvDataSourceAtRow.isSelected;
        
        NSIndexPath *prvSelectedIndexPath = [NSIndexPath indexPathForRow:sectionDataSource.lastChildOpenIndex inSection:indexPath.section];
        [self didSelectLevel2:prvSelectedIndexPath];
        
        [self.categoryTableView reloadRowsAtIndexPaths:@[prvSelectedIndexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        
        newIndex = prvDataSourceAtRow.category.childCategory.count;
        newIndex = prvSelectedIntex < indexPath.row ? (indexPath.row - newIndex) :indexPath.row;
    } else {
        newIndex = indexPath.row;
    }
    
    //new index path after deleting prv selected cell
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newIndex inSection:indexPath.section];
    CategoryDataSource *newCategoryDataSource = sectionDataSource.openRowDataSource[newIndexPath.row];
    
    newCategoryDataSource.isSelected = !newCategoryDataSource.isSelected;
    [self.categoryTableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:(UITableViewRowAnimationFade)];
    [self didSelectLevel2:newIndexPath];
}

- (void)didSelectLevel2:(NSIndexPath *)indexpath {
    
    CategoryDataSource *dataSourceAtSection = [self.categoryDataSource objectAtIndex:indexpath.section];
    CategoryDataSource *dataSourceAtRow = [dataSourceAtSection.openRowDataSource objectAtIndex:indexpath.row];
    
    NSMutableArray *insetIndexPathArray = [NSMutableArray new];
    NSMutableArray *deleteIndexPathArray = [NSMutableArray new];
    
    if (dataSourceAtRow.isSelected) {
        for(int i = 0 ; i < dataSourceAtRow.category.childCategory.count; i++) {
            
            Category *level2Category = dataSourceAtRow.category.childCategory[i];
            
            NSInteger index =  i + indexpath.row + 1;
            CategoryDataSource *level2CategoryDataSource = [[CategoryDataSource alloc] initWithCategory:level2Category];
            [dataSourceAtSection.openRowDataSource insertObject:level2CategoryDataSource atIndex:index];
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:index inSection:indexpath.section];
            [insetIndexPathArray addObject:insertIndexPath];
        }
        dataSourceAtSection.lastChildOpenIndex = indexpath.row;
        
    } else {
        for(int i = 0 ; i < dataSourceAtRow.category.childCategory.count ; i++) {
            NSInteger index = i + indexpath.row + 1;
            
            [dataSourceAtSection.openRowDataSource removeObjectAtIndex:indexpath.row+1];
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:index inSection:indexpath.section];
            [deleteIndexPathArray addObject:insertIndexPath];
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSelected == %@",@YES];
        NSArray *selectedThings = [dataSourceAtSection.openRowDataSource filteredArrayUsingPredicate:predicate];
        if (selectedThings.count) {
            dataSourceAtSection.lastChildOpenIndex = indexpath.row;
        } else {
            dataSourceAtSection.lastChildOpenIndex = -1;
        }
    }
    
    if (deleteIndexPathArray.count) {
        [self.categoryTableView deleteRowsAtIndexPaths:deleteIndexPathArray withRowAnimation:(UITableViewRowAnimationFade)];
    }else if (insetIndexPathArray.count != 0) {
        [self.categoryTableView insertRowsAtIndexPaths:insetIndexPathArray withRowAnimation:(UITableViewRowAnimationFade)];
    }
    
    
}


- (void)tapActionOnSectionHeader:(HeaderView *)headerView {
    
    self.currentSectionSelectedIndex = headerView.section;
    
    CategoryDataSource *currentCategoryDataSource = [self.categoryDataSource objectAtIndex:headerView.section];
    currentCategoryDataSource.isSelected = !currentCategoryDataSource.isSelected;
    
    NSMutableArray *insertRowIndexPathArray = [NSMutableArray new];
    
    
    //Add element on selected section if section is closed
    if(currentCategoryDataSource.isSelected) {
        
        for (int i = 0; i < currentCategoryDataSource.category.childCategory.count; i++) {
            
            Category *childCategory = currentCategoryDataSource.category.childCategory[i];
            
            CategoryDataSource *childCategoryDataSource = [[CategoryDataSource alloc] initWithCategory:childCategory];
            [currentCategoryDataSource.openRowDataSource addObject:childCategoryDataSource];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:headerView.section];
            [insertRowIndexPathArray addObject:indexPath];
        }
    }
    
    NSMutableArray *deleteRowIndexPathArray = [NSMutableArray new];
    
    //Remove Other section if it was open
    if (self.prevSectionSelectedIndex != -1) {
        
        CategoryDataSource *prvSectionDataSource = [self.categoryDataSource objectAtIndex:self.prevSectionSelectedIndex];
        
        if ((self.currentSectionSelectedIndex == self.prevSectionSelectedIndex && prvSectionDataSource.isSelected == false) || (self.currentSectionSelectedIndex != self.prevSectionSelectedIndex)) {
            
            prvSectionDataSource.isSelected = false;
            
            for (int i = 0; i < prvSectionDataSource.openRowDataSource.count; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:_prevSectionSelectedIndex];
                [deleteRowIndexPathArray addObject:indexPath];
            }
            [prvSectionDataSource.openRowDataSource removeAllObjects];
            
        }
    }
    
    [self.categoryTableView beginUpdates];
    if (insertRowIndexPathArray.count) {
        [self.categoryTableView insertRowsAtIndexPaths:insertRowIndexPathArray withRowAnimation:UITableViewRowAnimationFade];
    }
    
    if (deleteRowIndexPathArray.count) {
        [self.categoryTableView deleteRowsAtIndexPaths:deleteRowIndexPathArray withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.categoryTableView endUpdates];
    
    self.prevSectionSelectedIndex = self.currentSectionSelectedIndex;
}
@end
