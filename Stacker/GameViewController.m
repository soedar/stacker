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

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
    self.row = [[StackerRow alloc] initWithCount:1];
    [self.view addSubview:self.row];
     */
    
    [self initStackerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stopRow:(id)sender
{
    [self.stackerView moveToNextRow];
}
- (IBAction)reset:(id)sender
{
    [self.stackerView removeFromSuperview];
    [self initStackerView];
}

- (void) initStackerView
{
    NSArray *levelInfo = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StackerLevel" ofType:@"plist"]];
    
    self.stackerView = [[StackerView alloc] initWithLevel:levelInfo];
    self.stackerView.delegate = self;
    [self.view addSubview:self.stackerView];
    
    [self.stackerView start];
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
