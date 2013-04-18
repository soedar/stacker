//
//  PlaymonCheckoutViewController.h
//  Stacker
//
//  Created by soedar on 18/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftCard.h"

@interface PlaymonCheckoutViewController : UIViewController

@property (nonatomic, strong) GiftCard *giftCard;

- (id) initWithGiftCard:(GiftCard*)giftCard;

@end
