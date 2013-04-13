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
@property (nonatomic) int degreeOfFreedom;

@property (nonatomic) int position;
@property (nonatomic) int direction;


@property (nonatomic) uint8_t initialRowInfo;
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

- (id) initWithHighlightCount:(int)count cycleTime:(CGFloat)cycleTime;
{
    CGRect frame = CGRectMake(0, 0, ROW_SIZE*30, 30);
    self = [self initWithFrame:frame];
    if (self) {
        [self setupBoxes];
        _cycleTime = cycleTime;
        _initialHighlightCount = count;
        
        self.degreeOfFreedom = ROW_SIZE - count;
        self.position = 0;
        self.direction = DIRECTION_RIGHT;
    }
    return self;
}

- (uint8_t) initialRowInfo
{
    if (_initialRowInfo == 0) {
        uint8_t rowInfo = 0;
        for (int i=0;i<self.initialHighlightCount;i++) {
            rowInfo |= (1 << i);
        }
        _initialRowInfo = rowInfo;
    }
    return _initialRowInfo;
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

- (void) setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    self.rowInfo = (isActive) ? self.initialRowInfo : 0;
}

- (void) cycle {
    // Can't move at all if its not active or if all the light is maxed
    if (self.degreeOfFreedom == 0) {
        return;
    }
    
    if (self.position+1 > self.degreeOfFreedom) {
        self.direction = DIRECTION_LEFT;
    }
    if (self.position-1 < 0) {
        self.direction = DIRECTION_RIGHT;
    }
    
    self.position += self.direction;
    self.rowInfo = self.initialRowInfo << self.position;
}

@end
