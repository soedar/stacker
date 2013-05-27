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

@property (nonatomic, weak) IBOutlet UIView *purchaseInfoView;
@property (nonatomic, weak) IBOutlet UILabel *purchaseInfoLabel;

@property (nonatomic, weak) IBOutlet UIView *purchaseButtonView;
@property (nonatomic, weak) IBOutlet UIButton *purchaseButton;


@end

@implementation PBDealDetailsViewController

- (PBDealDetailsViewController*) initWithDeal:(PBDeal *)deal
{
    self = [super init];
    if (self) {
        _deal = deal;
        self.title = deal.name;
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self appendViewToContentView:[self viewForPurchaseButton]];
    [self appendViewToContentView:[self viewForImage]];
    [self appendViewToContentView:[self viewForPurchaseInfo]];
    [self appendViewToContentView:[self viewForDescription]];
    
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.frame.size;
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
    
    viewFrame.origin.y = contentFrame.size.height + CONTENT_PADDING;
    view.frame = viewFrame;
    
    contentFrame.size.height += view.frame.size.height + CONTENT_PADDING;
    self.contentView.frame = contentFrame;
    
    [self.contentView addSubview:view];
}

#pragma mark - Sections of view

- (UIView *) viewForImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.deal.image];
    imageView.center = CGPointMake(160, imageView.center.x);
    
    imageView.backgroundColor = [UIColor redColor];
    return imageView;
}

- (UIView *) viewForPurchaseButton
{
    NSString *buttonTitle = [NSString stringWithFormat:@"$%i", self.deal.cost];
    [self.purchaseButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    return self.purchaseButtonView;
}

- (UIView*) viewForPurchaseInfo
{
    self.purchaseInfoLabel.text = [NSString stringWithFormat:@"Purchase this for $%i and get %i x ", self.deal.cost, self.deal.life];
    
    return self.purchaseInfoView;
}

- (UIView*) viewForDescription
{
    self.descriptionLabel.text = self.deal.dealDescription;
    [self.descriptionLabel sizeToFit];
    
    return self.descriptionView;
}

@end