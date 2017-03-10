//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/8/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int) matchedTwoCard: (PlayingCard *) card {
    if (self.rank == card.rank) {
        return 4;
    } else if (self.suit == card.suit) {
        return 1;
    } else {
        return 0;
    }
}
- (int) matched:(NSArray *)otherCards {
    int score = 0;
    NSMutableArray *chosenCards = [otherCards mutableCopy];
    [chosenCards addObject:self];
    NSLog(@"%ld cards were chosen", [chosenCards count]);
    for (int i = 1; i < [chosenCards count]; i++) {
        for (int j = 0; j < i; j++) {
            score += [chosenCards[j] matchedTwoCard:chosenCards[i]];
        }
    }
    return score;
}
@synthesize suit = _suit;

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (void) setSuit:(NSString *) suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *) validSuits {
    return @[@"♠️", @"❤️", @"♣️", @"♦️"];
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [[self rankStrings] count] - 1;
}

- (void) setRank:(NSUInteger) rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end