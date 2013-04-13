//
//  StackerRow.h
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackerRow : UIView

@property (nonatomic) uint8_t rowInfo;
@property (nonatomic, readonly) int initialCount;
@property (nonatomic) BOOL isActive;

- (id) initWithCount:(int)count;
- (void) cycle;

@end
