//
//  HeaderView.h
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderView;
@protocol TapActionDelegate <NSObject>

- (void)tapActionOnSectionHeader:(HeaderView *)headerView;

@end

@interface HeaderView : UIView
@property (nonatomic,weak)   id<TapActionDelegate> delegate;
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,strong) UIButton *buttonArrow;
@property (nonatomic,strong) UILabel *labelTitle;

- (id)initWithFrame:(CGRect)frame andSection:(NSInteger )section;
@end
