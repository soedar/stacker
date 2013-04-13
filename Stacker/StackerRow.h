//
//  StackerRow.h
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackerRow : UIView

@property (nonatomic, readonly) int initialHighlightCount;
@property (nonatomic, readonly) CGFloat cycleTime;

@property (nonatomic) uint8_t rowInfo;
@property (nonatomic) BOOL isActive;

- (id) initWithHighlightCount:(int)count cycleTime:(CGFloat)cycleTime;
- (void) cycle;

@end
