//
//  TSGameViewController.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSGameViewController.h"

const int TSINTERACTION_TIME_THRESHOLD = 2;

@interface TSGameViewController ()

@end

@implementation TSGameViewController

@synthesize gameViewLayout;
@synthesize gameTimer, gameTimerLabel, gameTimerSeconds;
@synthesize interfaceInteractionTimer, interfaceInteractionTimerSeconds;
@synthesize lastSetTimeStamp;

@synthesize statsButton, addCardsButton;
@synthesize gameModel, gameStats, cardsInPlay;

- (void)initializeGame;
{
    // TODO changed hard-coded number of players
    gameModel = [TSGameModel getGameInstanceForPlayers:1 andClear:YES];
    gameStats = [gameModel gameStats];
    cardsInPlay = [gameModel deal];
    assert([cardsInPlay count] == TSSTARTING_SIZE);
}

- (void)viewDidLoad
{
    NSLog(@"ViewDidLoad");
    [super viewDidLoad];
    [self initializeGame];
    self.collectionView.allowsMultipleSelection = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"ViewWillAppear");
    [super viewWillAppear:animated];

}

- (void) viewDidAppear:(BOOL)animated
{
    NSLog(@"ViewDidAppear");
    gameTimer = [self createTimer:@selector(gameTimerTicked:)];
    [self showNavigationElements];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [gameTimer invalidate];
    [interfaceInteractionTimer invalidate];
}

- (IBAction)onShuffleCardsClick:(id)sender
{
    [self interfaceInteractionEvent];
}

- (IBAction)onAddCardsClick:(id)sender
{
    [self interfaceInteractionEvent];
    
    NSArray* nextCards = [gameModel dealNextCardsExtra:YES];
    NSMutableArray* indexPathsOfNextCards = [NSMutableArray arrayWithCapacity:[nextCards count]];
    for (TSCardModel* card in nextCards) {
        NSIndexPath* indexPathForCard = [NSIndexPath indexPathForItem:[card indexInGameBoard] inSection:0];
        [indexPathsOfNextCards addObject:indexPathForCard];
    }
    [[self collectionView] performBatchUpdates:^{
        [[self collectionView] insertItemsAtIndexPaths:indexPathsOfNextCards];
    } completion:nil];
    [self processMoreCards];
}

- (IBAction)onViewClick:(id)sender
{
    [self interfaceInteractionEvent];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Prepare for segue called");
    [gameStats updateJustInTime:gameTimerSeconds andCards:[cardsInPlay count] + [gameModel cardsRemainingInDesk]];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSCardCellView* selectedCell = (TSCardCellView*) [collectionView cellForItemAtIndexPath:indexPath];
    
    TSCardModel* selectedCard = [selectedCell card];
    TSGameModelReturnCode result = [gameModel addToWorkingSet:selectedCard];

    switch (result) {
        case TSGameModelValidSet:
            [self handleValidSetEventFromCollectionView:collectionView];
            break;
        
        case TSGameModelInvalidSet:
            [self handleInvalidSetEventFromCollectionView:collectionView];
            break;
            
        case TSGameModelIncompleteSet:
            return;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSCardCellView* deselectedCell = (TSCardCellView*) [collectionView cellForItemAtIndexPath:indexPath];
    TSCardModel* deselectedCard = [deselectedCell card];
    
    [gameModel removeFromWorkingSet:deselectedCard];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog([NSString stringWithFormat: @"numebrOfItems requested: %d", [gameModel cardsInPlayCount]]);
    return [gameModel cardsInPlayCount];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog([NSString stringWithFormat:@"CellQueried %d", [indexPath item]]);
    TSCardCellView* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCellID" forIndexPath:indexPath];
    
    UIView* blueColorView = [[UIView alloc] init];
    [blueColorView setBackgroundColor:[UIColor blueColor]];
    [cell setSelectedBackgroundView:blueColorView];
    
    [cell setSelectedBackgroundView:blueColorView];
    [cell assignCard:[cardsInPlay objectAtIndex:[indexPath item]]];
    return cell;
}

-(void)handleValidSetEventFromCollectionView:(UICollectionView*) collectionView
{
    NSLog(@"Valid set");
    BOOL addCards = [gameModel cardsInPlayCount] <= TSSTARTING_SIZE;
    
    TSSetModel* solvedSet = [gameModel processAndReturnSolvedSet];
    [self processStatsForSolvedSet:solvedSet];
    
    NSArray* selectedItems = [collectionView indexPathsForSelectedItems];
    
    NSMutableArray* indexPathsOfNextCards = [NSMutableArray array];
    
    if (addCards) {
        NSLog(@"Adding cards");
        NSArray* nextCards = [gameModel dealNextCardsExtra:NO];
        for (TSCardModel* card in nextCards) {
            NSIndexPath* indexPathForCard = [NSIndexPath indexPathForItem:[card indexInGameBoard] inSection:0];
            [indexPathsOfNextCards addObject:indexPathForCard];
        }
    } else {
        NSLog(@"Not adding cards");
    }

    [self processMoreCards];
    
    [collectionView performBatchUpdates:^{
        [collectionView deleteItemsAtIndexPaths:selectedItems];
        [collectionView insertItemsAtIndexPaths:indexPathsOfNextCards];
    } completion:nil];
    
    lastSetTimeStamp = gameTimerSeconds;
}

-(void)handleInvalidSetEventFromCollectionView:(UICollectionView*) collectionView
{
    NSLog(@"Invalid set");
    [collectionView performBatchUpdates:^{
        for (NSIndexPath* ip in [collectionView indexPathsForSelectedItems]) {
            [collectionView deselectItemAtIndexPath:ip animated:YES];
        }
    } completion:nil];
    
    [gameModel cancelWorkingSet];
}

-(void)processMoreCards
{
    [gameViewLayout updateBoardSize:[gameModel cardsInPlayCount]];
    
    [self updateStatsButton];
    [self checkForAdditionalCards];
}

-(void)processStatsForSolvedSet:(TSSetModel*)solvedSet
{
    int time = gameTimerSeconds - lastSetTimeStamp;
    int playerId = 0; // TODO: multiplayer
    TSSolvedSetProperties* properties = [[TSSolvedSetProperties alloc] initWithPlayer:playerId andTime:time andDesciption:[solvedSet desc]];
    [gameStats processSolvedSet:properties];
}

-(void)checkForAdditionalCards
{
    if ([gameModel cardsRemainingInDesk] == 0 || [gameModel definitelyASet]) {
        [addCardsButton setEnabled:NO];
    }
}

// referenced from
// http://stackoverflow.com/questions/3041256/basic-iphone-timer-example

- (NSTimer*)createTimer:(SEL)receiver
{
    return [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:receiver userInfo:nil repeats:YES];
}

- (void)gameTimerTicked:(NSTimer*)timer
{
    if ([self updateGameTimerCriteria]) {
        gameTimerSeconds += 1;
        NSString *timerTitle = [TSUtil formatTimeFromSeconds:gameTimerSeconds];
    
        [gameTimerLabel setTitle:timerTitle];
    }
}

- (void)interfaceInteractionTimerTicked:(NSTimer*)timer
{
    interfaceInteractionTimerSeconds += 1;
    if (interfaceInteractionTimerSeconds >= TSINTERACTION_TIME_THRESHOLD) {
        [self focusOnBoard];
        [interfaceInteractionTimer invalidate];
    }
}

- (void)interfaceInteractionEvent
{
    [self showNavigationElements];
}

- (void) focusOnBoard
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[self navigationController] setToolbarHidden:YES animated:YES];
    [interfaceInteractionTimer invalidate];
}

- (void) showNavigationElements
{
    interfaceInteractionTimerSeconds = 0;
    [interfaceInteractionTimer invalidate];
    interfaceInteractionTimer = [self createTimer:@selector(interfaceInteractionTimerTicked:)];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [[self navigationController] setToolbarHidden:NO animated:NO];
}

- (bool)updateGameTimerCriteria
{
    return ([self isViewLoaded] && [self.view window]);
}

- (void)updateStatsButton
{
    int cardsLeft = [gameModel cardsRemainingInDesk];
    [statsButton setTitle:[NSString stringWithFormat:@"%d", cardsLeft]];
}

@end
