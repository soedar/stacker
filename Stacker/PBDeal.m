//
//  PBDeal.m
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PBDeal.h"

@implementation PBDeal

- (PBDeal*) initWithDictionary:(NSDictionary *)dealDictionary
{
    self = [super init];
    if (self) {
        _name = dealDictionary[@"Name"];
        _life = [dealDictionary[@"Life"] intValue];
        _cost = [dealDictionary[@"Cost"] intValue];
        _dealDescription = dealDictionary[@"Description"];
        _image = [UIImage imageNamed:dealDictionary[@"ImageName"]];
    }
    return self;
}

- (NSString *)generateCardCode
{
    NSMutableString *cardCode = [NSMutableString string];
    for (int i=0;i<3;i++) {
        [cardCode appendFormat:@"%i", [self random4DigitNumber]];
        if (i < 2) {
            [cardCode appendString:@"-"];
        }
    }
    return cardCode;
}

- (int) random4DigitNumber
{
    return (int) (arc4random() % 9000) + 1000;
}

+ (PBDeal*) facebookConnectDeal
{
    NSDictionary *fbDict = @{@"Name": @"Connect your Facebook account",
                             @"Life": @(5),
                             @"Cost": @(0),
                             @"Description": @"",
                             @"ImageName": @"facebook-connect.png"};
    
    return [[PBDeal alloc] initWithDictionary:fbDict];
}

+ (PBDeal*) testDeal
{
    NSDictionary *testDict = @{@"Name": @"Apple iTunes X",
                               @"Life": @(3),
                               @"Cost": @(20),
                               @"Description": @"Apple iTunes is a entertainment thingy",
                               @"ImageName": @"itunes15.png"};
    
    return [[PBDeal alloc] initWithDictionary:testDict];
}

+ (PBDeal*) testDeal2
{
    NSDictionary *testDict = @{@"Name": @"Apple iTunes X",
                               @"Life": @(3),
                               @"Cost": @(20),
                               @"Description": @"Apple iTunes is a entertainment thingy",
                               @"ImageName": @"itunes25.png"};
    
    return [[PBDeal alloc] initWithDictionary:testDict];
}

@end
