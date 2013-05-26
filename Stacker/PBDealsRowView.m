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
    dealsRow.frame = CGRectMake(0, 0, 320, 200);
    
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
        
        xOffset += dealViewFrame.size.width + 20;
    }
    
    dealsRow.dealsScrollView.contentSize = CGSizeMake(xOffset, dealsRow.dealsScrollView.frame.size.height);
    
    return dealsRow;
}


- (void) dealTapped:(UIButton*)button
{
    NSLog(@"%i tapped", button.tag);
}
@end