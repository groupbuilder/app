//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/9/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) BOOL isBeginning;
@property (nonatomic, readwrite) NSString *status;
@property (nonatomic, readwrite) NSMutableArray *history;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    self.twoMatchGame = YES;
    self.history = [[NSMutableArray alloc] init];
    return self;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (NSMutableString *) chosenCardsTitles {
    NSMutableString *titles = [[NSMutableString alloc] init];
    for (Card *card in _cards) {
        if (card.isChosen && !card.isMatched) {
            [titles appendString:card.contents];
        }
    }
    return titles;
}
- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    card.everChosen = YES;
    if (!card.isMatched) {
        self.isBeginning = NO;
        NSMutableString *statusString = [[NSMutableString alloc] init];
        if (card.isChosen) {
            card.chosen = NO;
            _status = [self chosenCardsTitles];
        } else {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            card.chosen = YES;
            statusString = [self chosenCardsTitles];
            if ((self.twoMatchGame && [otherCards count] == 1)
                || (!self.twoMatchGame && [otherCards count] == 2)) {
                int matchScore = [card matched:otherCards];
                if (matchScore) {
                    [statusString appendString:[NSString stringWithFormat:@"matched, got %d points", MATCH_BONUS * matchScore]];
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    [statusString appendString:[NSString stringWithFormat:@"didn't match penalty %d points", MISMATCH_PENALTY]];
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            _status = statusString;
        }
        [self.history addObject:_status];
    }
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index] : nil;
}

- (void) resetGame {
    for (Card *card in self.cards) {
        card.chosen = NO;
        card.matched = NO;
        card.everChosen = NO;
    }
    self.score = 0;
    self.isBeginning = YES;
}
@end
