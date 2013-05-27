//
//  PBDealDetailsViewController.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealDetailsViewController.h"

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
   
    [self addPurchaseButton];
    
    [self appendViewToContentView:[self viewForImage]];
    [self appendViewToContentView:[self viewForDescription]];
    
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.frame.size;
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navy_blue_.png"]];
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
    
}

#pragma mark - Sections of view

- (void) addPurchaseButton
{
    NSString *costTitle = [NSString stringWithFormat:@"$%i", self.deal.cost];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:costTitle style:UIBarButtonItemStyleBordered target:self action:@selector(purchaseItem)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (UIView *) viewForImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.deal.image];
    
    CGRect frame = imageView.frame;
    frame.size.width = 320;
    frame.size.height = 197;
    imageView.frame = frame;
    
    imageView.backgroundColor = [UIColor redColor];
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