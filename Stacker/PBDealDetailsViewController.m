//
//  PBDealDetailsViewController.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealDetailsViewController.h"
#import "PBDealCheckoutViewController.h"
#import <QuartzCore/QuartzCore.h>

#define CONTENT_PADDING     20;

@interface PBDealDetailsViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *descriptionView;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, weak) IBOutlet UILabel *purchaseInfoLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionNameLabel;


@end

@implementation PBDealDetailsViewController

- (PBDealDetailsViewController*) initWithDeal:(PBDeal *)deal
{
    self = [super init];
    if (self) {
        _deal = deal;
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    [self appendViewToContentView:[self viewForImage]];
    [self appendViewToContentView:[self viewForDescription]];
    [self appendViewToContentView:[self viewForPurchaseButton]];
    
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.frame.size;
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navy_blue.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) appendViewToContentView:(UIView*)view
{
    CGRect viewFrame = view.frame;
    CGRect contentFrame = self.contentView.frame;
    
    viewFrame.origin.y = contentFrame.size.height;
    view.frame = viewFrame;
    
    contentFrame.size.height += view.frame.size.height + CONTENT_PADDING;
    self.contentView.frame = contentFrame;
    
    [self.contentView addSubview:view];
}

#pragma mark - Purchase

- (void)purchaseItem
{
    PBDealCheckoutViewController *checkoutVC = [[PBDealCheckoutViewController alloc] initWithDeal:self.deal];
    
    [self.navigationController pushViewController:checkoutVC animated:YES];
}

#pragma mark - Sections of view

- (UIView*) viewForPurchaseButton
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

- (UIView *) viewForImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.deal.image];
    
    CGRect frame = imageView.frame;
    frame.size.width = 320;
    frame.size.height = 197;
    imageView.frame = frame;
    
    return imageView;
}

- (UIView*) viewForDescription
{
    self.purchaseInfoLabel.text = [NSString stringWithFormat:@"Buy this for $%i and get %i x ", self.deal.cost, self.deal.life];
    
    self.descriptionNameLabel.text = self.deal.name;
    self.descriptionLabel.text = self.deal.dealDescription;
    [self.descriptionLabel sizeToFit];
    
    return self.descriptionView;
}

@end