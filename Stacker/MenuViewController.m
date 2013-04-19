//
//  MenuViewController.m
//  Stacker
//
//  Created by soedar on 17/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@interface MenuViewController ()

@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

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
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupPlayButton];
    self.titleLabel.textColor = TEXT_COLOR;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setupPlayButton
{
    self.playButton.backgroundColor = BUTTON_BACKGROUND_COLOR;
    self.playButton.layer.masksToBounds = YES;
    self.playButton.layer.cornerRadius = 8.0f;
    
    [self.playButton setTitle:@"PLAY" forState:UIControlStateNormal];
    [self.playButton setTitleColor:BUTTON_TEXT_COLOR forState:UIControlStateNormal];
}


#pragma mark - Button action

- (IBAction)playPressed:(id)sender
{
    GameViewController *gameViewController = [[GameViewController alloc] init];
    [self presentViewController:gameViewController animated:YES completion:nil];
}



@end
