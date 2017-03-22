//
//  HeaderView.m
//  EcommDemo
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 jk. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
- (id)initWithFrame:(CGRect)frame andSection:(NSInteger )section {
    self = [super initWithFrame:frame];
    
    [self createLabelTitle];
    [self createButtonArrow];
    [self addLineView];
    
    self.section = section;
    self.isOpen = false;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionSelectionAction:)];
    [self addGestureRecognizer:tap];
    
    return self;
}

- (void)createButtonArrow {
    
    CGRect buttonArrowFream = CGRectMake(self.frame.size.width - 40, 0, 20, 12);
    self.buttonArrow = [[UIButton alloc] initWithFrame:buttonArrowFream];
    self.buttonArrow.center = CGPointMake(self.buttonArrow.center.x, self.center.y);
    [self.buttonArrow setImage:[UIImage imageNamed:@"ic_down_arrow"] forState:UIControlStateNormal];
    [self.buttonArrow setImage:[UIImage imageNamed:@"ic_up_arrow"] forState:UIControlStateSelected];
    
    [self addSubview:self.buttonArrow];
}

- (void)createLabelTitle {
    
    self.labelTitle = [UILabel new];
    self.labelTitle.frame = CGRectMake(20, 0, self.frame.size.width - 45, 21);
    self.labelTitle.center = self.center;
    self.labelTitle.textColor = [UIColor darkGrayColor];
    
    [self addSubview:self.labelTitle];
}

- (void)addLineView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.frame.size.width, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}

- (void)sectionSelectionAction:(id)sender {
    self.isOpen = !self.isOpen;
    self.buttonArrow.selected = !self.buttonArrow.selected;
    [self.delegate tapActionOnSectionHeader:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
