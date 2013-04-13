//
//  StackerBox.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "StackerBox.h"
#import "Constants.h"

#define BOX_FRAME_IPHONE    CGRectMake(0,0,BOX_SIZE_IPHONE,BOX_SIZE_IPHONE)

@interface StackerBox ()

@property (nonatomic, strong) UIColor *highlightColor;
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

- (id)initWithHighlightColor:(UIColor *)highlightColor
{
    self = [self initWithFrame:BOX_FRAME_IPHONE];
    if (self) {
        self.highlightColor = highlightColor;
        self.passiveColor = [UIColor lightGrayColor];
        
        [self setupBoxView];
    }
    return self;
}

- (void) setupBoxView
{
    self.boxView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:self.boxView];
    
    self.isHighlighted = NO;
}

- (void) setIsHighlighted:(BOOL)isHighlighted
{
    _isHighlighted = isHighlighted;
    self.boxView.backgroundColor = (isHighlighted) ? self.highlightColor : self.passiveColor;
}
@end
