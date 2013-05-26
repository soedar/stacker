//
//  PBDeal.h
//  Stacker
//
//  Created by soedar on 25/5/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBDeal : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, readonly) int life;
@property (nonatomic, readonly) int cost;
@property (nonatomic, strong, readonly) NSString *dealDescription;
@property (nonatomic, strong, readonly) UIImage *image;

- (PBDeal*) initWithDictionary:(NSDictionary*)dealDictionary;

+ (PBDeal*) testDeal;
+ (PBDeal*) testDeal2;

@end
