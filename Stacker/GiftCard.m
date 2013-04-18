//
//  GiftCard.m
//  Stacker
//
//  Created by soedar on 17/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "GiftCard.h"

@implementation GiftCard

+ (GiftCard*) giftCardWithImage:(UIImage *)image
                      storeName:(NSString *)storeName
                       distance:(NSString *)distance
                          title:(NSString *)title
                     coinsValue:(int)coins
{
    GiftCard *giftCard = [[GiftCard alloc] initWithImage:image storeName:storeName distance:distance title:title coinsValue:coins];
    return giftCard;
}

- (id) initWithImage:(UIImage*)image
           storeName:(NSString*)storeName
            distance:(NSString*)distance
               title:(NSString*)title
          coinsValue:(int)coins
{
    self = [super init];
    if (self) {
        _image = image;
        _storeName = storeName;
        _distance = distance;
        _title = title;
        _coins = coins;
    }
    return self;
}

@end
