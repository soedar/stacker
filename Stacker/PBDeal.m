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

@end
