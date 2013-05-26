//
//  PBDealsViewController.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealsViewController.h"

#import "PBDeal.h"
#import "PBDealView.h"

@interface PBDealsViewController ()

@property (nonatomic, weak) IBOutlet UITableView *dealsTableView;

@end

@implementation PBDealsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"PlayBulb";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addBackButton
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style:UIBarButtonItemStyleBordered
                                   target:self action:@selector(dismissPlaybulbController)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void) dismissPlaybulbController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView datasource and delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DealsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    PBDeal *deal = [PBDeal testDeal];
    if (indexPath.row % 2 == 0) {
        deal = [PBDeal testDeal2];
    }
    PBDealView *dealView = [PBDealView dealViewForDeal:deal target:nil action:NULL];
    
    [cell.contentView addSubview:dealView];
    
    return cell;
}

@end
