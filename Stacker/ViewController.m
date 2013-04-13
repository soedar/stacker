//
//  ViewController.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "ViewController.h"
#import "StackerView.h"

@interface ViewController () <StackerViewDelegate>
@property (nonatomic, strong) StackerView *stackerView;

@end

@implementation ViewController

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
    self.stackerView = [[StackerView alloc] initWithRows:8];
    self.stackerView.delegate = self;
    [self.view addSubview:self.stackerView];
    
    [self.stackerView start];
}


#pragma mark - Delegate method

- (void) stackerView:(StackerView *)stackerView gameOverWithLastCompletedRow:(int)row
{
    NSString *message = @"Not good enough!";
    if (row == 8) {
        message = @"Ok good job!";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

@end
