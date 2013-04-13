//
//  StackerBox.h
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackerBox : UIView

@property (nonatomic) BOOL isHighlighted;

- (id) initWithHighlightColor:(UIColor*)highlightColor;

@end
