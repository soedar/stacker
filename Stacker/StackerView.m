//
//  StackerView.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "StackerView.h"
#import "StackerRow.h"
#import "Constants.h"

#define ROW_Y_OFFSET    2

#define HIGHLIGHT_COUNT_KEY     @"highlightCount"
#define CYCLE_TIME_KEY          @"cycleTime"

@interface StackerView ()

@property (nonatomic) int rows;
@property (nonatomic) int activeRowId;
@property (nonatomic, strong) NSArray *stackerRows;
@property (nonatomic, strong) NSTimer *mainTimer;
@property (nonatomic, strong) NSArray *levelInfo;

@end
@implementation StackerView

- (id) initWithLevel:(NSArray*)levelInfo
{
    self = [super init];
    if (self) {
        self.rows = levelInfo.count;
        self.levelInfo = [[levelInfo reverseObjectEnumerator] allObjects];
        [self setupStackerRows];
    }
    return self;
}

- (void) setupStackerRows
{
    NSMutableArray *stackerRows = [NSMutableArray array];
    
    CGFloat yOffset = 0;
    for (int i=0;i<self.rows;i++) {
        int highlightCount = [self.levelInfo[i][HIGHLIGHT_COUNT_KEY] intValue];
        CGFloat cycleTime = [self.levelInfo[i][CYCLE_TIME_KEY] floatValue];
        
        StackerRow *row = [[StackerRow alloc] initWithDefaultHighlightCount:highlightCount cycleTime:cycleTime];
        [stackerRows addObject:row];
        [self addSubview:row];
        
        CGRect frame = row.frame;
        frame.origin.y = yOffset;
        row.frame = frame;
        
        yOffset += frame.size.height + ROW_Y_OFFSET;
    }
    
    self.stackerRows = [[stackerRows reverseObjectEnumerator] allObjects];
    
    // Update the frame
    StackerRow *row = self.stackerRows[0];
    self.frame = CGRectMake(0,0,row.frame.size.width,yOffset-ROW_Y_OFFSET);
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
    [self.currentRow activateWithHighlightCount:self.currentRow.defaultHighlightCount];
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
    int highlightCount = [self.currentRow deactivateWithFinalHighlightCount];
   
    if (highlightCount > 0 && self.activeRowId+1 < self.rows) {
        self.activeRowId++;
        
        highlightCount = MIN(highlightCount, self.currentRow.defaultHighlightCount);
        [self.currentRow activateWithHighlightCount:highlightCount];
    
        self.mainTimer = [self timerForRow:self.currentRow];
    }
    
    else {
        if ([self.delegate respondsToSelector:@selector(stackerView:gameOverWithLastCompletedRow:)]) {
            if (highlightCount > 0) {
                [self.delegate stackerView:self gameOverWithLastCompletedRow:self.activeRowId];
            }
            else {
                [self.delegate stackerView:self gameOverWithLastCompletedRow:self.activeRowId-1];
            }
        }
    }
}

- (NSTimer*) timerForRow:(StackerRow *)row
{
    NSLog(@"%f", row.cycleTime);
    return [NSTimer scheduledTimerWithTimeInterval:row.cycleTime target:self selector:@selector(cycle:) userInfo:nil repeats:YES];
}

@end
