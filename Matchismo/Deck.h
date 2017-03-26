//
//  Deck.h
//  Matchismo
//
//  Created by Jianqun Chen on 11/8/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#ifndef Matchismo_Deck_h
#define Matchismo_Deck_h

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard : (Card *) card atTop:(BOOL) atTop;
- (void) addCard : (Card *) card;
- (Card *) drawRandomCard;

@end
#endif
