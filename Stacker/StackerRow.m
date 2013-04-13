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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithDefaultHighlightCount:(int)defaultCount cycleTime:(CGFloat)cycleTime
{
    CGRect frame = CGRectMake(0, 0, ROW_SIZE*30, 30);
    self = [self initWithFrame:frame];
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
    int degreeOfFreedom = ROW_SIZE - self.highlightCount;
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
