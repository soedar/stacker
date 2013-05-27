//
//  PBDealCheckoutViewController.m
//  Stacker
//
//  Created by soedar on 27/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealCheckoutViewController.h"

@interface PBDealCheckoutViewController ()

@property (nonatomic, weak) IBOutlet UILabel *descriptionNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *purchaseInfoLabel;


@property (nonatomic, weak) IBOutlet UITableView *checkoutTableView;


@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *creditCardTextField;

@property (nonatomic, strong) UIView *csvAndExpiryView;
@property (nonatomic, strong) UITextField *csvTextField;
@property (nonatomic, strong) UITextField *expiryTextField;


@end

@implementation PBDealCheckoutViewController

- (PBDealCheckoutViewController*) initWithDeal:(PBDeal *)deal
{
    self = [super init];
    if (self) {
        _deal = deal;
        self.title = @"Checkout";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navy_blue.png"]];
    
    [self updateDealInformation];
    
    [self.checkoutTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) updateDealInformation
{
    self.purchaseInfoLabel.text = [NSString stringWithFormat:@"Buy this for $%i and get %i x ", self.deal.cost, self.deal.life];
    
    self.descriptionNameLabel.text = self.deal.name;
}

- (UIView*) viewForIndexPath:(NSIndexPath*)indexPath
{
    int row = indexPath.row;
    
    if (row == 0) {
        if (!self.emailTextField) {
            self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 185, 30)];
            self.emailTextField.placeholder = @"E-mail";
        }
        return self.emailTextField;
    }

    else if (row == 1) {
        if (!self.creditCardTextField) {
            self.creditCardTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 185, 30)];
            self.creditCardTextField.placeholder = @"Credit Card";
        }
        return self.creditCardTextField;
    }

    else if (row == 2) {
        if (!self.csvAndExpiryView) {
            self.csvAndExpiryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            self.expiryTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
            self.expiryTextField.placeholder = @"MMYY";
            
            self.csvTextField = [[UITextField alloc] initWithFrame:CGRectMake(200, 10, 50, 30)];
            self.csvTextField.placeholder = @"CSV";
            
            [self.csvAndExpiryView addSubview:self.csvTextField];
            [self.csvAndExpiryView addSubview:self.expiryTextField];
            
        }
        
        return self.csvAndExpiryView;
    }

    else if (row == 3) {
        if (!self.nameTextField) {
            self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 185, 30)];
            self.nameTextField.placeholder = @"Name";
        }
        return self.nameTextField;
    }

    return nil;
}

#pragma mark - TableView delegate and datasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *checkoutCell = @"CheckoutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:checkoutCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:checkoutCell];
    }

    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:[self viewForIndexPath:indexPath]];
    
    return cell;
}



@end
