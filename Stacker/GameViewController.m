//
//  ViewController.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "GameViewController.h"
#import "StackerView.h"

@interface GameViewController () <StackerViewDelegate>
@property (nonatomic, strong) StackerView *stackerView;
@property (nonatomic, weak) IBOutlet UILabel *coinsLabel;

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
    self.coins = 3;
    
    [self initStackerView];
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
    
    [self.stackerView start];
}

- (void) setCoins:(int)coins
{
    _coins = coins;
    self.coinsLabel.text = [NSString stringWithFormat:@"x %i", coins];
}

#pragma mark - Button action

- (IBAction)stopRow:(id)sender
{
    [self.stackerView moveToNextRow];
}

- (IBAction)reset:(id)sender
{
    [self.stackerView removeFromSuperview];
    [self initStackerView];
}

#pragma mark - Delegate method

- (void) stackerView:(StackerView *)stackerView gameOverWithLastCompletedRow:(int)row
{
    NSArray *levelInfo = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StackerLevel" ofType:@"plist"]];
    
    NSString *message = @"Not good enough!";
    if (row == levelInfo.count-1) {
        message = @"Ok good job!";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

@end
