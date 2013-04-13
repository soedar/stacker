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
@property (nonatomic) int activeRow;
@property (nonatomic, strong) NSArray *stackerRows;

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
        [self activateRow:0];
    }
    return self;
}

- (void) setupStackerRows
{
    NSMutableArray *stackerRows = [NSMutableArray array];
    
    CGFloat yOffset = 0;
    for (int i=0;i<self.rows;i++) {
        StackerRow *row = [[StackerRow alloc] initWithCount:3];
        [stackerRows addObject:row];
        [self addSubview:row];
        
        CGRect frame = row.frame;
        frame.origin.y = yOffset;
        row.frame = frame;
        
        yOffset += frame.size.height + ROW_Y_OFFSET;
    }
    
    self.stackerRows = [[stackerRows reverseObjectEnumerator] allObjects];
}

- (void) activateRow:(int)row
{
    StackerRow *stackerRow = self.stackerRows[self.activeRow];
    stackerRow.isActive = NO;
    
    self.activeRow = row;
    stackerRow = self.stackerRows[self.activeRow];
    stackerRow.isActive = YES;
}

@end
