//
//  StackerView.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "StackerView.h"
#import "StackerRow.h"

#define ROW_Y_OFFSET    2

@interface StackerView ()

@property (nonatomic) int rows;
@property (nonatomic) int activeRowId;
@property (nonatomic, strong) NSArray *stackerRows;
@property (nonatomic, strong) NSTimer *mainTimer;

@end
@implementation StackerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithRows:(int)rows
{
    CGRect frame = CGRectMake(0, 0, 30*7, 30*rows);
    self = [self initWithFrame:frame];
    if (self) {
        self.rows = rows;
        [self setupStackerRows];
    }
    return self;
}

- (void) setupStackerRows
{
    NSMutableArray *stackerRows = [NSMutableArray array];
    
    CGFloat yOffset = 0;
    for (int i=0;i<self.rows;i++) {
        StackerRow *row = [[StackerRow alloc] initWithHighlightCount:3 cycleTime:0.3];
        [stackerRows addObject:row];
        [self addSubview:row];
        
        CGRect frame = row.frame;
        frame.origin.y = yOffset;
        row.frame = frame;
        
        yOffset += frame.size.height + ROW_Y_OFFSET;
    }
    
    self.stackerRows = [[stackerRows reverseObjectEnumerator] allObjects];
}

- (StackerRow*) currentRow
{
    return self.stackerRows[self.activeRowId];
}
- (StackerRow*) previousRow
{
    return (self.activeRowId > 0) ? self.stackerRows[self.activeRowId-1] : nil;
}

#pragma mark - Stacker Controls

- (void) start
{
    self.currentRow.isActive = YES;
    self.mainTimer = [self timerForRow:self.currentRow];
}

- (void) cycle:(NSTimer*)timer
{
    [self.currentRow cycle];
}

- (void) moveToNextRow
{
    [self.mainTimer invalidate];
    
    if (self.previousRow) {
        self.currentRow.rowInfo &= self.previousRow.rowInfo;
    }
    
    self.activeRowId++;
    self.currentRow.isActive = YES;
    
    self.mainTimer = [self timerForRow:self.currentRow];
}

- (NSTimer*) timerForRow:(StackerRow *)row
{
    return [NSTimer scheduledTimerWithTimeInterval:row.cycleTime target:self selector:@selector(cycle:) userInfo:nil repeats:YES];
}

@end
