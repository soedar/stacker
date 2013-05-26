//
//  PBDealView.h
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBDeal.h"

@interface PBDealView : UIView

+ (PBDealView*) dealViewForDeal:(PBDeal*)deal target:(id)target action:(SEL)action;

- (UIButton*) button;

@end
