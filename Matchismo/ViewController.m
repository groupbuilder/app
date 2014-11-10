//
//  ViewController.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/8/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameSwitch;
@end

@implementation ViewController
- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}
- (Deck *) deck {
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}
- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}
- (void) setFlipsCount:(int)flipsCount {
    _flipsCount = flipsCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
    NSLog(@"Flips %d times", self.flipsCount);
}
- (IBAction)touchCardButton:(UIButton *)sender {
<<<<<<< HEAD
    long chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}
- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.gameSwitch.enabled = self.game.isBeginning;
    }
}
- (NSString *) titleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}
- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
- (IBAction)resetButton:(UIButton *)sender {
    [self.game resetGame];
    [self updateUI];
}
- (IBAction)gameSwitch:(UISwitch *)sender {
    self.game.twoMatchGame = [sender isOn] ? YES : NO;
}

@end
