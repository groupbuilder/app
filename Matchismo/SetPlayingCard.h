//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Jianqun Chen on 11/16/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface SetPlayingCard : Card

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *symbol;

+ (NSUInteger)maxNumber;
+ (NSArray *)validColor;
+ (NSArray *)validShading;
+ (NSArray *)validSymbol;
@end
