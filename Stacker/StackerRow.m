//
//  StackerRow.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "StackerRow.h"
#import "StackerBox.h"
#import "Constants.h"

#define BOX_MARGIN_X    2

#define DIRECTION_LEFT  -1
#define DIRECTION_RIGHT 1

@interface StackerRow ()

@property (nonatomic, strong) NSArray *stackerBoxes;

@property (nonatomic) int position;
@property (nonatomic) int direction;

@property (nonatomic) uint8_t initialRowInfo;
@property (nonatomic) int highlightCount;

@end

@implementation StackerRow

#pragma mark - Class method
+ (uint8_t) initialRowInfoForHighlightedCount:(int)highlightedCount
{
    uint8_t rowInfo = 0;
    for (int i=0;i<highlightedCount;i++) {
        rowInfo |= (1 << i);
    }
    
    return rowInfo;
}

- (id) initWithDefaultHighlightCount:(int)defaultCount cycleTime:(CGFloat)cycleTime
{
    self = [super init];
    if (self) {
        [self setupBoxes];
        _defaultHighlightCount = defaultCount;
        _cycleTime = cycleTime;
        self.position = 0;
        self.direction = DIRECTION_RIGHT;
    }
    return self;
}

- (void) setupBoxes
{
    NSMutableArray *boxes = [NSMutableArray array];
    CGFloat xOffset = 0;
    for (int i=0;i<COLUMN_COUNT;i++) {
        StackerBox *box = [[StackerBox alloc] initWithHighlightColor:[UIColor blueColor]];
        [boxes addObject:box];
        [self addSubview:box];
        
        CGRect frame = box.frame;
        frame.origin.x = xOffset;
        box.frame = frame;
        
        xOffset += frame.size.width + BOX_MARGIN_X;
    }
    
    self.stackerBoxes = [[NSArray alloc] initWithArray:boxes];
    
    // Update the frame of the view
    self.frame = CGRectMake(0,0,xOffset-BOX_MARGIN_X,BOX_SIZE_IPHONE);
}

- (void) setRowInfo:(uint8_t)rowInfo
{
    _rowInfo = rowInfo;

    // Toggle the right boxes
    for (int i=0;i<COLUMN_COUNT;i++) {
        StackerBox *box = self.stackerBoxes[i];
        BOOL isActive = (rowInfo & (1<<i));
        
        box.isHighlighted = isActive;
    }
}

- (void) activateWithHighlightCount:(int)highlightCount
{
    self.rowInfo = [StackerRow initialRowInfoForHighlightedCount:highlightCount];
    self.initialRowInfo = self.rowInfo;
    self.highlightCount = highlightCount;
}

- (int) deactivateWithFinalHighlightCount
{
    int count = 0;
    for (int i=0;i<7;i++) {
        if (self.rowInfo & (1 <<i)) {
            count++;
        }
    }
    return count;
}

- (void) cycle {
    int degreeOfFreedom = COLUMN_COUNT - self.highlightCount;
    // Can't move at all if its not active or if all the light is maxed
    if (degreeOfFreedom == 0) {
        return;
    }
    
    if (self.position+1 > degreeOfFreedom) {
        self.direction = DIRECTION_LEFT;
    }
    if (self.position-1 < 0) {
        self.direction = DIRECTION_RIGHT;
    }
    
    self.position += self.direction;
    self.rowInfo = self.initialRowInfo << self.position;
}

@end
