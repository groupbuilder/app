//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jianqun Chen on 11/8/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#ifndef Matchismo_PlayingCard_h
#define Matchismo_PlayingCard_h

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
#endif
