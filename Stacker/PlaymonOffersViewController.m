//
//  PlaymonOffersViewController.m
//  Stacker
//
//  Created by soedar on 17/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PlaymonOffersViewController.h"
#import "Constants.h"
#import "GiftCard.h"
#import "PlaymonCheckoutViewController.h"

@interface PlaymonOffersViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *cardScrollView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *headerLabel;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@end

@implementation PlaymonOffersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Get more coins";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headerLabel.text = @"Header";
    self.titleLabel.text = @"Title";
    
    NSArray *giftCards = [self getGiftCards];
    
    self.pageControl.pageIndicatorTintColor = PAGE_INDICATOR_COLOR;
    self.pageControl.currentPageIndicatorTintColor = CURRENT_PAGE_INDICATOR_COLOR;
    self.pageControl.numberOfPages = giftCards.count;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    self.cardScrollView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self setupScrollViewWithCards:giftCards];
    [self updateLabelsForPage:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupScrollViewWithCards:(NSArray*)giftCards
{
    for (int i=0;i<giftCards.count;i++) {
        GiftCard *giftCard = giftCards[i];
        
        CGSize frameSize = self.cardScrollView.bounds.size;
        CGFloat xOrigin = (frameSize.width) * i;
        CGRect frame = CGRectMake(xOrigin, 0, frameSize.width, frameSize.height);
        
        UIView *view = [[UIView alloc] initWithFrame:frame];
        
        CGRect buttonFrame = CGRectMake(0,0,230,150);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = buttonFrame;
        button.tag = i;
        [button addTarget:self action:@selector(cardTapped:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:giftCard.image forState:UIControlStateNormal];
        [view addSubview:button];
        
        button.center = CGPointMake(frameSize.width/2, button.center.y);
        
        [self.cardScrollView addSubview:view];
        xOrigin += frame.size.width;
    }
    CGSize size = self.cardScrollView.frame.size;
    size.width *= giftCards.count;
    self.cardScrollView.contentSize = size;
}

- (void) updateLabelsForPage:(int)page
{
    GiftCard *giftCard = [self getGiftCards][page];
    
    NSString *header = giftCard.storeName;
    if (giftCard.distance) {
        header = [NSString stringWithFormat:@"%@, %@", header, giftCard.distance];
    }
    
    self.headerLabel.text = header;
    self.titleLabel.text = giftCard.title;
/*
    [self.titleLabel sizeToFit];
    CGPoint center = self.titleLabel.center;
    center.x = self.view.center.x;
    self.titleLabel.center = center;
 */
}

#pragma mark - Button Action

- (void) cardTapped:(UIButton*)button
{
    int tag = button.tag;
    GiftCard *giftCard = [self getGiftCards][tag];
    
    PlaymonCheckoutViewController *checkOutVC = [[PlaymonCheckoutViewController alloc] initWithGiftCard:giftCard];
    [self.navigationController pushViewController:checkOutVC animated:YES];
}

#pragma mark - Scroll View Delegate

- (void) scrollViewStopped
{
    [self updateLabelsForPage:self.pageControl.currentPage];
    [UIView animateWithDuration:0.3 animations:^{
        self.headerLabel.alpha = 1;
        self.titleLabel.alpha = 1;
    }];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.headerLabel.alpha = 0;
        self.titleLabel.alpha = 0;
    }];
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth
                      / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewStopped];
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewStopped];
}

#pragma mark - PageControl Callback

- (void) changePage:(UIPageControl*)pageControl
{
    CGFloat xOffset = pageControl.currentPage * self.cardScrollView.frame.size.width;
    [self.cardScrollView setContentOffset:CGPointMake(xOffset,0) animated:YES];
}

#pragma mark - Data
- (NSArray*) getGiftCards
{
    GiftCard *appleCard = [GiftCard giftCardWithImage:[UIImage imageNamed:@"itunes15.png"] storeName:@"Apple" distance:nil title:@"Get 3 coins when you buy a $15 gift card" coinsValue:3];
    GiftCard *amazonCard = [GiftCard giftCardWithImage:[UIImage imageNamed:@"amazon.png"] storeName:@"Amazon" distance:nil title:@"Get 4 coins when you buy a $20 gift card" coinsValue:3];
    GiftCard *mcdonaldsCard = [GiftCard giftCardWithImage:[UIImage imageNamed:@"mcdonalds.png"] storeName:@"McDonald's" distance:@"10m away" title:@"Get 3 coins when you buy a $10 gift card" coinsValue:3];
    return [NSArray arrayWithObjects:appleCard, amazonCard, mcdonaldsCard, nil];
}

@end
