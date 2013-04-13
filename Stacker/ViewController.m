//
//  ViewController.m
//  Stacker
//
//  Created by soedar on 12/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "ViewController.h"
#import "StackerBox.h"
#import "StackerRow.h"

@interface ViewController ()
@property (nonatomic, strong) StackerRow *row;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.row = [[StackerRow alloc] initWithCount:4];
    [self.view addSubview:self.row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cycleRow:(id)sender
{
    [self.row cycle];
}

@end
