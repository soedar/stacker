//
//  StackerRow.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "StackerRow.h"
#import "StackerBox.h"

#define ROW_SIZE        7
#define BOX_MARGIN_X    2

@interface StackerRow ()

@property (nonatomic, strong) NSArray *stackerBoxes;

@end

@implementation StackerRow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithRowInfo:(uint8_t)rowInfo
{
    CGRect frame = CGRectMake(0, 0, ROW_SIZE*30, 30);
    self = [self initWithFrame:frame];
    if (self) {
        [self setupBoxes];
        
        self.rowInfo = rowInfo;
    }
    return self;
}


- (void) setupBoxes
{
    NSMutableArray *boxes = [NSMutableArray array];
    CGFloat xOffset = 0;
    for (int i=0;i<ROW_SIZE;i++) {
        StackerBox *box = [[StackerBox alloc] initWithActiveColor:[UIColor blueColor]];
        [boxes addObject:box];
        [self addSubview:box];
        
        CGRect frame = box.frame;
        frame.origin.x = xOffset;
        box.frame = frame;
        
        xOffset += frame.size.width + BOX_MARGIN_X;
    }
    
    self.stackerBoxes = [[NSArray alloc] initWithArray:boxes];
}

- (void) setRowInfo:(uint8_t)rowInfo
{
    _rowInfo = rowInfo;

    // Toggle the right boxes
    for (int i=0;i<ROW_SIZE;i++) {
        StackerBox *box = self.stackerBoxes[i];
        BOOL isActive = (rowInfo & (1<<i));
        
        box.isActive = isActive;
    }
}

@end
