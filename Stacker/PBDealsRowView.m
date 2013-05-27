//
//  PBDealsRowView.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealsRowView.h"
#import "PBDeal.h"
#import "PBDealView.h"

#define GAP_SIZE    20

@interface PBDealsRowView ()

@property (nonatomic, weak) IBOutlet UIScrollView *dealsScrollView;
@property (nonatomic, weak) IBOutlet UILabel *headerLabel;

@property (nonatomic, strong) NSArray *deals;
@end

@implementation PBDealsRowView

+ (id) getViewFromNib {
    NSString *className = [[self class] description];
    NSArray *xib = [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil];
    
    return xib[0];
}

+ (PBDealsRowView*) dealsRowWithHeader:(NSString *)header deals:(NSArray *)deals
{
    PBDealsRowView *dealsRow = [PBDealsRowView getViewFromNib];
    dealsRow.frame = CGRectMake(0, 0, 320, 210);
    
    
    CGRect dealsScrollViewFrame = dealsRow.dealsScrollView.frame;
    dealsScrollViewFrame.size.width = 305;
    dealsScrollViewFrame.size.height = 160;
    dealsRow.dealsScrollView.frame = dealsScrollViewFrame;
    
    dealsRow.deals = deals;
    dealsRow.headerLabel.text = header;
    
    int count = 0;
    CGFloat xOffset = 0;
    for (PBDeal *deal in deals) {
        PBDealView *dealView = [PBDealView dealViewForDeal:deal target:dealsRow action:@selector(dealTapped:)];
        dealView.button.tag = count++;
        
        CGRect dealViewFrame = dealView.frame;
        dealViewFrame.origin.x = xOffset;
        dealView.frame = dealViewFrame;
        [dealsRow.dealsScrollView addSubview:dealView];
        
        xOffset += dealViewFrame.size.width + GAP_SIZE;
    }
    
    dealsRow.dealsScrollView.contentSize = CGSizeMake(xOffset-GAP_SIZE, dealsRow.dealsScrollView.frame.size.height);
    
    return dealsRow;
}


+ (PBDealsRowView*) fbDealRow
{
    PBDealsRowView *dealsRow = [PBDealsRowView getViewFromNib];
    dealsRow.frame = CGRectMake(0, 0, 320, 210);
    
    
    CGRect dealsScrollViewFrame = dealsRow.dealsScrollView.frame;
    dealsScrollViewFrame.size.width = 305;
    dealsScrollViewFrame.size.height = 160;
    dealsRow.dealsScrollView.frame = dealsScrollViewFrame;
   
    PBDeal *fbDeal = [PBDeal facebookConnectDeal];
    
    dealsRow.deals = @[fbDeal];
    dealsRow.headerLabel.text = @"Special Offers";
    
    int count = 0;
    CGFloat xOffset = 0;
    PBDealView *dealView = [PBDealView dealViewForDeal:fbDeal target:dealsRow action:@selector(fbDealTapped:)];
    dealView.button.tag = count++;
    
    CGRect dealViewFrame = dealView.frame;
    dealViewFrame.origin.x = xOffset;
    dealView.frame = dealViewFrame;
    [dealsRow.dealsScrollView addSubview:dealView];
    
    xOffset += dealViewFrame.size.width + GAP_SIZE;
    
    dealsRow.dealsScrollView.contentSize = CGSizeMake(xOffset-GAP_SIZE, dealsRow.dealsScrollView.frame.size.height);
    
    return dealsRow;
}



- (void) dealTapped:(UIButton*)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowDealDetail" object:self.deals[button.tag]];
}

- (void) fbDealTapped:(UIButton*)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FacebookConnected" object:[PBDeal facebookConnectDeal]];
}
@end
