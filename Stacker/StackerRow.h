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

- (id) initWithRowInfo:(uint8_t)rowInfo;

@end
