//
//  PlaymonCheckoutViewController.m
//  Stacker
//
//  Created by soedar on 18/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PlaymonCheckoutViewController.h"
#import "Constants.h"

@interface PlaymonCheckoutViewController ()

@end

@implementation PlaymonCheckoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithGiftCard:(GiftCard *)giftCard
{
    self = [super init];
    if (self) {
        self.giftCard = giftCard;
        self.title = @"Checkout";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkoutTapped:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Checkout Complete!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    [self.navigationController popViewControllerAnimated:YES];
    
    NSNumber *coins = @(self.giftCard.coins);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADD_COINS object:self userInfo:@{COINS_KEY: coins}];
}

@end
