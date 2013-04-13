//
//  StackerRow.h
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackerRow : UIView

@property (nonatomic, readonly) int defaultHighlightCount;
@property (nonatomic, readonly) CGFloat cycleTime;
@property (nonatomic) uint8_t rowInfo;

- (id) initWithDefaultHighlightCount:(int)defaultCount cycleTime:(CGFloat)cycleTime;
- (void) activateWithHighlightCount:(int)highlightCount;
- (int) deactivateWithFinalHighlightCount;
- (void) cycle;

@end
