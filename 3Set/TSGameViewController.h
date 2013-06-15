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

extern const int TSINTERACTION_TIME_THRESHOLD;

@interface TSGameViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *gameTimerLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *statsButton;

@property (strong) NSTimer* gameTimer;
@property (strong) NSTimer* interfaceInteractionTimer;
@property (assign) int gameTimerSeconds;
@property int interfaceInteractionTimerSeconds;

@property (strong) TSGameModel* gameModel;
@property (weak) NSArray* cardsInPlay;

@end

