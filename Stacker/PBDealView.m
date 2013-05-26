//
//  PBDealView.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDealView.h"

@interface PBDealView ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *lifeLabel;
@property (nonatomic, weak) IBOutlet UILabel *costLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *button;

@property (nonatomic, strong) PBDeal *deal;
@end

@implementation PBDealView

+ (id) getViewFromNib {
    NSString *className = [[self class] description];
    NSArray *xib = [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil];
    
    return xib[0];
}

+ (PBDealView*) dealViewForDeal:(PBDeal *)deal target:(id)target action:(SEL)action
{
    PBDealView *dealView = [PBDealView getViewFromNib];
    dealView.frame = CGRectMake(0, 0, 260, 160);
    
    [dealView.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    dealView.nameLabel.text = deal.name;
    dealView.costLabel.text = [NSString stringWithFormat:@"$%i", deal.cost];
    dealView.lifeLabel.text = [NSString stringWithFormat:@"x %i", deal.life];
    dealView.imageView.image = deal.image;
    
    dealView.deal = deal;
    
    return dealView;
}


@end
