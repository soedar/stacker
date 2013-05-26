//
//  PBDealDetailsViewController.h
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBDeal.h"

@interface PBDealDetailsViewController : UIViewController

- (PBDealDetailsViewController*) initWithDeal:(PBDeal*)deal;

@property (nonatomic, strong, readonly) PBDeal *deal;

@end
