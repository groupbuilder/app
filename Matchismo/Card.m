//
//  Card.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/8/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)matched:(NSArray *)otherCards {
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score++;
        }
    }
    return score;
}

@end