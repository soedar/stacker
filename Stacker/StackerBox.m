//
//  StackerBox.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "StackerBox.h"

@interface StackerBox ()

@property (nonatomic, strong) UIColor *activeColor;
@property (nonatomic, strong) UIColor *passiveColor;
@property (nonatomic, strong) UIView *boxView;

@end

@implementation StackerBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithActiveColor:(UIColor *)activeColor
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.activeColor = activeColor;
        self.passiveColor = [UIColor lightGrayColor];
        
        [self setupBoxView];
    }
    return self;
}

- (void) setupBoxView
{
    self.boxView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:self.boxView];
    
    self.isActive = NO;
}

- (void) setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    self.boxView.backgroundColor = (isActive) ? self.activeColor : self.passiveColor;
}
@end
