//
//  TextViewController.m
//  Matchismo
//
//  Created by Jianqun Chen on 11/17/14.
//  Copyright (c) 2014 Jianqun Chen. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation TextViewController
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}
- (void) updateUI {
    NSMutableString *text = [[NSMutableString alloc] init];
    for (NSString *line in self.history) {
        [text appendString:line];
        [text appendString:@"\n"];
    }
    self.historyTextView.text = text;
}
@end
