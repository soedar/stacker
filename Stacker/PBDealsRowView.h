//
//  PBDealsRowView.h
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBDealsRowView : UIView

+ (PBDealsRowView*) dealsRowWithHeader:(NSString*)header deals:(NSArray*)deals;
+ (PBDealsRowView*) fbDealRow;

@end
