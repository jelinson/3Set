//
//  TSGameViewController.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSGameModel.h"
#import "TSCardModel.h"
#import "TSCardCellView.h"
#import "TSGameViewLayout.h"
#import "TSGameStatsModel.h"

extern const int TSINTERACTION_TIME_THRESHOLD;

@interface TSGameViewController : UICollectionViewController

@property (assign) BOOL hideFrameDuringPlay;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gameTimerLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *statsButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addCardsButton;
@property (weak, nonatomic) IBOutlet TSGameViewLayout *gameViewLayout;

@property (strong) NSTimer* gameTimer;
@property (strong) NSTimer* interfaceInteractionTimer;
@property (assign) int gameTimerSeconds;
@property (assign) int interfaceInteractionTimerSeconds;
@property (assign) int lastSetTimeStamp;

@property (strong) TSGameModel* gameModel;
@property (weak) TSGameStatsModel* gameStats;
@property (weak) NSArray* cardsInPlay;

@end

