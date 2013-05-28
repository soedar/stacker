//
//  PBDealCheckoutViewController.m
//  Stacker
//
//  Created by soedar on 27/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealCheckoutViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"
#import "Constants.h"
#import "MBProgressHUD.h"

@interface PBDealCheckoutViewController ()

@property (nonatomic, weak) IBOutlet UIView *descriptionView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *purchaseInfoLabel;


@property (nonatomic, weak) IBOutlet UITableView *checkoutTableView;


@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *creditCardTextField;

@property (nonatomic, strong) UIView *csvAndExpiryView;
@property (nonatomic, strong) UITextField *csvTextField;
@property (nonatomic, strong) UITextField *expiryTextField;

@property (nonatomic, strong) UIButton *purchaseButton;

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
    [self setupTextFields];
    
    // Listen for keyboard appearances and disappearances
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.purchaseButton = [self getPurchaseButton];
    CGRect frame = self.purchaseButton.frame;
    frame.origin.y = self.checkoutTableView.frame.origin.y + self.checkoutTableView.frame.size.height + 20;
    self.purchaseButton.frame = frame;
    [self.view addSubview:self.purchaseButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) keyboardDidShow:(NSNotification*)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.descriptionView.transform = CGAffineTransformMakeTranslation(0, -80);
        self.checkoutTableView.transform = CGAffineTransformMakeTranslation(0, -80);
        self.purchaseButton.transform = CGAffineTransformMakeTranslation(0, -80);
    }];
}

- (void) keyboardDidHide:(NSNotification*)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.descriptionView.transform = CGAffineTransformIdentity;
        self.checkoutTableView.transform = CGAffineTransformIdentity;
        self.purchaseButton.transform = CGAffineTransformIdentity;
    }];
}

- (void) purchaseItem
{
    NSArray *textFields = @[self.emailTextField, self.creditCardTextField, self.csvTextField, self.nameTextField, self.expiryTextField];
    
    for (UITextField *textField in textFields) {
        [textField resignFirstResponder];
        [textField setEnabled:NO];
    }
    
    NSString *name = (self.nameTextField.text) ? self.nameTextField.text : @"Playbulb User";
    
    NSString *title = [NSString stringWithFormat:@"Redemption code for %@", self.deal.name];
    NSString *content = [NSString stringWithFormat:@"Dear %@,\n\nThank you for your recent purchase of %@ on the Playbulb Platform.\n\nHere is your redemption code: %@.\n\nWarmest Regards,\nTeam Playbulb",
                         name,
                         self.deal.name,
                         [self.deal generateCardCode]
                         ];
    
    if (self.emailTextField.text == nil || [self.emailTextField.text isEqualToString:@""]) {
        [self showPurchaseCompleteAlert];
    }
    
    else {
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://johngoh.org/"]];
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                                path:@"http://johngoh.org/playbulb/email.php"
                                                          parameters:@{@"to": self.emailTextField.text,
                                        @"subject": title, @"message": content}];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showPurchaseCompleteAlert];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showPurchaseCompleteAlert];
        }];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Performing Transactions...";
        [operation start];
    }
}

- (void) showPurchaseCompleteAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:@"You will receive an email shortly with redemption instructions" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_ADD_COINS object:self userInfo:@{COINS_KEY: @(self.deal.life)}];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resignTextFieldResponders:(id)sender
{
    NSArray *textFields = @[self.emailTextField, self.creditCardTextField, self.csvTextField, self.nameTextField, self.expiryTextField];
    
    for (UITextField *textField in textFields) {
        [textField resignFirstResponder];
    }
}

- (void) updateDealInformation
{
    self.purchaseInfoLabel.text = [NSString stringWithFormat:@"Buy this for $%i and get %i x ", self.deal.cost, self.deal.life];
    
    self.descriptionNameLabel.text = self.deal.name;
}

- (void) setupTextFields
{
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 220, 30)];
    self.emailTextField.placeholder = @"E-mail";
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    
    self.creditCardTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 220, 30)];
    self.creditCardTextField.placeholder = @"Credit Card";
    self.creditCardTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.csvAndExpiryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.expiryTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
    self.expiryTextField.placeholder = @"MMYY";
    self.expiryTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.csvTextField = [[UITextField alloc] initWithFrame:CGRectMake(200, 10, 50, 30)];
    self.csvTextField.placeholder = @"CSV";
    self.csvTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.csvAndExpiryView addSubview:self.csvTextField];
    [self.csvAndExpiryView addSubview:self.expiryTextField];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 220, 30)];
    self.nameTextField.placeholder = @"Name";
    
    
    NSArray *textFields = @[self.emailTextField, self.creditCardTextField, self.csvTextField, self.nameTextField, self.expiryTextField];
    
    for (UITextField *textField in textFields) {
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.delegate = self;
    }
    
    
    
    [self setDefaultValuesForTextField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



- (void) setDefaultValuesForTextField
{
    self.nameTextField.text = @"Soedar";
    self.emailTextField.text = @"soedar.sg@gmail.com";
    self.creditCardTextField.text = @"378282246310005";
    self.expiryTextField.text = @"04/15";
    self.csvTextField.text = @"243";
}

- (UIView*) viewForIndexPath:(NSIndexPath*)indexPath
{
    int row = indexPath.row;
    
    if (row == 0) {
        return self.emailTextField;
    }

    else if (row == 1) {
        return self.creditCardTextField;
    }

    else if (row == 2) {
        return self.csvAndExpiryView;
    }

    else if (row == 3) {
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


- (UIButton *) getPurchaseButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 130, 40);
    
    btn.center = CGPointMake(160, btn.center.y);
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    // Set default backgrond color
    [btn setBackgroundColor:[UIColor blueColor]];
    
    // Add Custom Font
    NSString *titleString = [NSString stringWithFormat:@"Buy for $%i", self.deal.cost];
    [btn setTitle:titleString forState:UIControlStateNormal];
    
    // Draw a custom gradient
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = btn.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:105.0f / 255.0f green:188.0f / 255.0f blue:235.0f / 255.0f alpha:1.0f] CGColor],
                          (id)[[UIColor colorWithRed:10.0f / 255.0f green:144.0f / 255.0f blue:222.0f / 255.0f alpha:1.0f] CGColor],
                          nil];
    
    [btn.layer insertSublayer:btnGradient atIndex:0];
    
    
    // Round button corners
    CALayer *btnLayer = [btn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    
    // Apply a 1 pixel border around Buy Button
    [btnLayer setBorderWidth:1.0f];
    [btnLayer setBorderColor:[[UIColor colorWithRed:10.0f / 255.0f green:144.0f / 255.0f blue:222.0f / 255.0f alpha:1.0f] CGColor]];
    
    [btn addTarget:self action:@selector(purchaseItem) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
