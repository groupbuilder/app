//
//  SetViewController.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/16/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "SetViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingSetCardDeck.h"
#import "SetPlayingCard.h"
#import "CardMatchingGame.h"

@interface SetViewController()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation SetViewController

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *) createDeck {
    return [[PlayingSetCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    long chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                  forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.statusLabel.font = [UIFont systemFontOfSize:8];
    self.statusLabel.text = self.game.status;
}
- (NSAttributedString *) titleForCard:(Card *) card {
    return card.everChosen ? card.attributedContents : [[NSAttributedString alloc] initWithString:@"" attributes:nil];
}
- (UIImage *) backgroundImageForCard:(Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : (card.everChosen ? @"cardchosen" : @"cardback")];
}
- (IBAction)resetButton:(UIButton *)sender {
    [self.game resetGame];
    [self updateUI];
}
- (void)viewDidLoad {
    for (UIButton *button in self.cardButtons) {
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    self.game.twoMatchGame = NO;
}
@end
