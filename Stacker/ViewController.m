//
//  ViewController.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "ViewController.h"
#import "StackerView.h"

@interface ViewController ()
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
    
    self.stackerView = [[StackerView alloc] initWithRows:4];
    [self.view addSubview:self.stackerView];
    
    [self.stackerView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cycleRow:(id)sender
{
    [self.stackerView moveToNextRow];
}

@end
