//
//  GiftCard.h
//  Stacker
//
//  Created by soedar on 17/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftCard : NSObject

+ (GiftCard*) giftCardWithImage:(UIImage*)image
                      storeName:(NSString*)storeName
                       distance:(NSString*)distance
                          title:(NSString*)title
                     coinsValue:(int)coins
                      cardValue:(int)cardValue;

@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong, readonly) NSString *storeName;
@property (nonatomic, strong, readonly) NSString *distance;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, readonly) int coins;
@property (nonatomic, readonly) int cardValue;

@end
