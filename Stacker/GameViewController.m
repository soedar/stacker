//
//  ViewController.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "GameViewController.h"
#import "StackerView.h"
#import "Constants.h"
#import "PlaymonOffersViewController.h"

@interface GameViewController () <StackerViewDelegate>
@property (nonatomic, strong) StackerView *stackerView;
@property (nonatomic, weak) IBOutlet UILabel *coinsLabel;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;

@property (nonatomic, weak) IBOutlet UIButton *resetButton;
@property (nonatomic, weak) IBOutlet UILabel *resetLabel;
@property (nonatomic, strong) UIAlertView *outOfCoinsAlert;

@property (nonatomic) int coins;

@end

@implementation GameViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.coins = INITIAL_COINS;
    
    [self initStackerView];
    self.stopButton.hidden = YES;
    
    /*
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat
                     animations:^{
                         self.resetLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     }
                     completion:nil];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initStackerView
{
    NSArray *levelInfo = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StackerLevel" ofType:@"plist"]];
    
    self.stackerView = [[StackerView alloc] initWithLevel:levelInfo];
    
    CGRect frame = self.stackerView.frame;
    frame.origin.y = 50;
    self.stackerView.frame = frame;
    
    self.stackerView.center = CGPointMake(self.view.center.x, self.stackerView.center.y);
    self.stackerView.delegate = self;
    [self.view addSubview:self.stackerView];
}

- (void) setCoins:(int)coins
{
    _coins = coins;
    self.coinsLabel.text = [NSString stringWithFormat:@"x %i", coins];
}

#pragma mark - Alert views

- (void) showOutOfCoinsAlert
{
    self.outOfCoinsAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Out of coins!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Buy Coins", @"Get Free Coins", nil];
    [self.outOfCoinsAlert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *iapAlert = [[UIAlertView alloc] initWithTitle:@"Launch In App Purchase window" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    UIViewController *playmonController = [self playmonController];
    
    switch (buttonIndex) {
        case 1:
            [iapAlert show];
            break;
        case 2:
            [self presentViewController:playmonController
                               animated:YES completion:nil];
            break;
    }
}

- (UIViewController *)playmonController
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style:UIBarButtonItemStyleBordered
                                   target:self action:@selector(dismissPlaymonViewController)];
    
    PlaymonOffersViewController *offersController = [[PlaymonOffersViewController alloc] init];
    UINavigationController *offersNavController = [[UINavigationController alloc] initWithRootViewController:offersController];
    
    offersController.navigationItem.leftBarButtonItem = backButton;
    
    NSArray *tabViewControllers = [[NSArray alloc] initWithObjects:offersNavController, nil];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:tabViewControllers animated:YES];
    
    return tabBarController;
}

- (void) dismissPlaymonViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Button action

- (IBAction)stopRow:(id)sender
{
    [self.stackerView moveToNextRow];
}

- (IBAction)reset:(id)sender
{
    if (self.coins == 0) {
        // Dont do nothing, user ran out of life
        [self showOutOfCoinsAlert];
    }
    else {
        self.coins--;
        self.resetButton.hidden = YES;
        self.resetLabel.hidden = YES;
        self.stopButton.hidden = NO;
        [self.stackerView removeFromSuperview];
        [self initStackerView];
        [self.stackerView start];
    }
}

#pragma mark - Delegate method

- (void) stackerView:(StackerView *)stackerView gameOverWithLastCompletedRow:(int)row
{
    self.stopButton.hidden = YES;
    self.resetButton.hidden = NO;
    self.resetLabel.hidden = NO;
    
    NSArray *levelInfo = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StackerLevel" ofType:@"plist"]];
    
    if (row == levelInfo.count-1) {
        NSString *message = @"Ok good job! You won!";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }

}

@end
