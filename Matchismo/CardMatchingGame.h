//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jianqun Chen on 11/9/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#ifndef Matchismo_CardMatchingGame_h
#define Matchismo_CardMatchingGame_h

#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger) index;

- (Card *) cardAtIndex:(NSUInteger) index;

- (void) resetGame;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) BOOL isBeginning;
@property (nonatomic) BOOL twoMatchGame;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic, readonly) NSMutableArray *history;

@end
#endif
