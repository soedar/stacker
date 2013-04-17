//
//  StackerView.h
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StackerView;

@protocol StackerViewDelegate <NSObject>

- (void)stackerView:(StackerView*)stackerView gameOverWithLastCompletedRow:(int)row;

@end

@interface StackerView : UIView

@property (nonatomic, assign) id<StackerViewDelegate> delegate;

- (id) initWithLevel:(NSArray*)levelInfo;
- (void) start;
- (void) moveToNextRow;

@end
