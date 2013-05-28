//
//  PBDealCheckoutViewController.h
//  Stacker
//
//  Created by soedar on 27/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBDeal.h"

@interface PBDealCheckoutViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) PBDeal *deal;

- (PBDealCheckoutViewController*) initWithDeal:(PBDeal *)deal;

@end
