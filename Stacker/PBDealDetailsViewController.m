//
//  PBDealDetailsViewController.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealDetailsViewController.h"

@interface PBDealDetailsViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation PBDealDetailsViewController

- (PBDealDetailsViewController*) initWithDeal:(PBDeal *)deal
{
    self = [super init];
    if (self) {
        _deal = deal;
        self.title = deal.name;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.image = self.deal.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
