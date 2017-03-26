//
//  PlayingSetCardDeck.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/16/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "PlayingSetCardDeck.h"
#import "SetPlayingCard.h"

@implementation PlayingSetCardDeck

- (instancetype) init {
    self = [super init];
    if (self) {
        for (int n = 1; n <= [SetPlayingCard maxNumber]; n++) {
            for (NSString *color in [SetPlayingCard validColor]) {
                for (NSString *shading in [SetPlayingCard validShading]) {
                    for (NSString *symbol in [SetPlayingCard validSymbol]) {
                        SetPlayingCard *card = [[SetPlayingCard alloc] init];
                        card.number = n;
                        card.color = color;
                        card.shading = shading;
                        card.symbol = symbol;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}
@end
