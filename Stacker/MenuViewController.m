//
//  MenuViewController.m
//  Stacker
//
//  Created by soedar on 17/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button action

- (IBAction)playPressed:(id)sender
{
    GameViewController *gameViewController = [[GameViewController alloc] init];
    [self presentViewController:gameViewController animated:YES completion:nil];
}

@end