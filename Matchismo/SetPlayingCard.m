//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/16/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard

- (NSAttributedString *) attributedContents {
    NSMutableString *stringContents = [[NSMutableString alloc] initWithString:_symbol];
    NSString *nextLine = [NSString stringWithFormat:@"\n%@", _symbol];
    for (int i = 1; i < _number; i++) {
        [stringContents appendString:nextLine];
    }
    NSLog(@"contests = %@", stringContents);
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:stringContents attributes:nil];
    float redDegree = [_color isEqualToString:@"red"] ? 1.0 : 0.0;
    float greenDegree = [_color isEqualToString:@"green"] ? 1.0 : 0.0;
    float blueDegree = [_color isEqualToString:@"blue"] ? 1.0 : 0.0;
    float alphaDegree = [_shading isEqualToString:@"striped"] ? 0.3 : 1.0;
    [contents addAttributes:@{NSForegroundColorAttributeName
                              :[UIColor colorWithRed:redDegree green:greenDegree blue:blueDegree alpha:alphaDegree],
                              NSStrokeWidthAttributeName
                              :[_shading isEqualToString:@"open"] ? @0 : @10}
                      range:NSMakeRange(0, [stringContents length])];
    return contents;
}
- (NSString *) contents {
    return [NSString stringWithFormat:@"[%ld %@ %@ %@]", _number, _color, _shading, _symbol];
}
- (NSString *) kthProperty:(int) k {
    if (k == 1) {
        return [NSString stringWithFormat:@"%ld", _number];
    } else if (k == 2) {
        return _color;
    } else if (k == 3) {
        return _shading;
    } else {
        return _symbol;
    }
}

- (int)matched:(NSArray *) otherCards {
    NSMutableArray *chosenCards = [otherCards mutableCopy];
    [chosenCards addObject:self];
    if ([chosenCards count] == 3) {
        for (int k = 1; k <= 4; k++) {
            NSString *ak = [chosenCards[0] kthProperty:k];
            NSString *bk = [chosenCards[1] kthProperty:k];
            NSString *ck = [chosenCards[2] kthProperty:k];
            NSLog(@"ak = %@, bk = %@, ck = %@\n", ak, bk, ck);
            if (([ak isEqualToString:bk] && ![ak isEqualToString:ck])
                || ([ak isEqualToString:ck] && ![ak isEqualToString:bk])
                ||([bk isEqualToString:ck] && ![bk isEqualToString:ak])) {
                return 0;
            }
        }
    }
    return 1;
}

+ (NSUInteger) maxNumber {
    return 3;
}
+ (NSArray *) validColor {
    return @[@"red", @"green", @"blue"];
}
+ (NSArray *) validShading {
    return @[@"solid", @"striped", @"open"];
}
+ (NSArray *) validSymbol {
    return @[@"△", @"○", @"◻︎"];
}
@end
