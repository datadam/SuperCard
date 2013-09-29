//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by Derek Taylor on 9/24/13.
//  Copyright (c) 2013 Derek Taylor. All rights reserved.
//

#import "SuperCardViewController.h"
#import "PlayingCardView.h"
#import "SetCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "SetCard.h"
#import "SetCardDeck.h"

@interface SuperCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;
@property (strong, nonatomic) Deck *playingCardDeck;
@property (strong, nonatomic) Deck *setCardDeck;
@end

@implementation SuperCardViewController

- (Deck *)playingCardDeck
{
    if (!_playingCardDeck) _playingCardDeck = [[PlayingCardDeck alloc] init];
    return _playingCardDeck;
}
- (Deck *)setCardDeck
{
    if (!_setCardDeck) _setCardDeck = [[SetCardDeck alloc] init];
    return _setCardDeck;
}

- (void)setPlayingCardView:(PlayingCardView *)playingCardView
{
    _playingCardView = playingCardView;
    [self drawRandomPlayingCard];
    playingCardView.faceUp = YES;
}

- (void)setSetCardView:(SetCardView *)setCardView
{
    _setCardView = setCardView;
    [self drawRandomSetCard];
}

- (void)drawRandomPlayingCard
{
    Card *playingCard = [self.playingCardDeck drawRandomCard];
    if ([playingCard isKindOfClass:[PlayingCard class]]) {
        PlayingCard *pc = (PlayingCard *)playingCard;
        self.playingCardView.rank = pc.rank;
        self.playingCardView.suit = pc.suit;
    }
}
- (void)drawRandomSetCard
{
    Card *setCard = [self.setCardDeck drawRandomCard];
    if ([setCard isKindOfClass:[SetCard class]]) {
        SetCard *sc = (SetCard *)setCard;
        self.setCardView.number = sc.number;
        self.setCardView.symbol = sc.symbol;
        self.setCardView.shading = sc.shading;
        self.setCardView.color = sc.color;
        [self.setCardView setNeedsDisplay];
        NSLog(@"Drew a %@ %@ %d %@ ",
              (sc.color == kRed) ? @"red" : (sc.color == kGreen) ? @"green" : @"purple",
              (sc.shading == kOpen) ? @"open" : (sc.shading == kSolid) ? @"solid" : @"striped",
              (sc.number == kOne) ? 1 : (sc.number == kTwo) ? 2 : 3,
              (sc.symbol == kDiamond) ? @"diamond" : (sc.symbol == kOval) ? @"oval" : @"squiggle");
    }
}
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    [UIView transitionWithView:self.playingCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (!self.playingCardView.faceUp) [self drawRandomPlayingCard];
                        self.playingCardView.faceUp = !self.playingCardView.faceUp;
                    }
                    completion:NULL];
}
- (IBAction)tapSetCard:(UITapGestureRecognizer *)sender {
    [UIView transitionWithView:self.setCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self drawRandomSetCard];
                    }
                    completion:NULL];
}

@end
