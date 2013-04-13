//
//  StackerRow.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "StackerRow.h"

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
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.rowInfo = rowInfo;
    }
    return self;
}

@end
