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

@property (nonatomic) BOOL hasFbConnect;

@end

@implementation PBDealsViewController

+ (NSDictionary*) dealsRowsFromPlist
{
    static NSDictionary *finalDealsRows;
    
    if (!finalDealsRows) {
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"PlaybulbDeals" ofType:@"plist"];
        
        NSDictionary *deals = [NSDictionary dictionaryWithContentsOfFile:dataPath];
        
        NSMutableDictionary *dealsRows = [NSMutableDictionary dictionary];
        for (NSString *category in deals[@"CATEGORIES"]) {
            NSMutableArray *dealsInfo = [NSMutableArray array];
            
            NSArray *dealsDictInfo = deals[category];
            for (NSDictionary *dealInfo in dealsDictInfo) {
                PBDeal *deal = [[PBDeal alloc] initWithDictionary:dealInfo];
                [dealsInfo addObject:deal];
            }
            
            dealsRows[category] = dealsInfo;
        }

        finalDealsRows = dealsRows;
    }
    
    return finalDealsRows;
}

+ (NSArray*) categoryOrder
{
    static NSArray *categoryOrder;
    if (!categoryOrder) {
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"PlaybulbDeals" ofType:@"plist"];
        NSDictionary *deals = [NSDictionary dictionaryWithContentsOfFile:dataPath];
        categoryOrder = deals[@"CATEGORIES"];
    }
    
    return categoryOrder;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"PlayBulb";
        self.hasFbConnect = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackButton];
    [self registerNotification];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navy_blue.png"]];
    
    [PBDealsViewController dealsRowsFromPlist];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFbConnect:) name:@"FacebookConnected" object:nil];
}

- (void) showDeal:(NSNotification*) notification
{
    PBDeal *deal = notification.object;
    
    PBDealDetailsViewController *dealDetailVc = [[PBDealDetailsViewController alloc] initWithDeal:deal];
    
    [self.navigationController pushViewController:dealDetailVc animated:YES];
}

- (void) showFbConnect:(NSNotification*) notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook Connected!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    self.hasFbConnect = YES;
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.dealsTableView reloadData];
}

- (void) dismissPlaybulbController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView datasource and delegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.hasFbConnect) {
        return 2;
    }
    
    else {
        return [PBDealsViewController categoryOrder].count;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DealsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    int row = indexPath.row;
    NSDictionary *dealsRows = [PBDealsViewController dealsRowsFromPlist];
    NSArray *categories = [PBDealsViewController categoryOrder];
    
    PBDealsRowView *rowView = nil;
    if (!self.hasFbConnect) {
        if (row == 1) {
            rowView = [PBDealsRowView fbDealRow];
        }
    }
    
    if (!rowView) {
        NSString *category = categories[row];
        rowView = [PBDealsRowView dealsRowWithHeader:category
                                               deals:dealsRows[category]];
    }
    
    [cell.contentView addSubview:rowView];
    
    return cell;
}

@end
