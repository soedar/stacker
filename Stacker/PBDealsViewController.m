//
//  PBDealsViewController.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealsViewController.h"

#import "PBDeal.h"
#import "PBDealsRowView.h"
#import "PBDealDetailsViewController.h"

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
    [self registerNotification];
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

- (void) registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDeal:) name:@"ShowDealDetail" object:nil];
}

- (void) showDeal:(NSNotification*) notification
{
    PBDeal *deal = notification.object;
    
    PBDealDetailsViewController *dealDetailVc = [[PBDealDetailsViewController alloc] initWithDeal:deal];
    
    [self.navigationController pushViewController:dealDetailVc animated:YES];
}

- (void) dismissPlaybulbController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView datasource and delegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DealsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    NSArray *deals = @[[PBDeal testDeal], [PBDeal testDeal2], [PBDeal testDeal]];
    PBDealsRowView *rowView = [PBDealsRowView dealsRowWithHeader:@"Popular Deals" deals:deals];
    
    [cell.contentView addSubview:rowView];
    
    return cell;
}

@end
