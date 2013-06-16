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

@synthesize gameTimer, gameTimerLabel, gameTimerSeconds;
@synthesize interfaceInteractionTimer, interfaceInteractionTimerSeconds;
@synthesize lastSetTimeStamp;

@synthesize statsButton, addCardsButton;
@synthesize gameModel, cardsInPlay;

- (void)initializeGame;
{
    gameModel = [[TSGameModel alloc] init];
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
}

- (IBAction)onViewClick:(id)sender
{
    [self interfaceInteractionEvent];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSCardCellView* selectedCell = (TSCardCellView*) [collectionView cellForItemAtIndexPath:indexPath];
    TSCardModel* selectedCard = [selectedCell card];
    TSGameModelReturnCode result = [gameModel addToWorkingSet:selectedCard];

    switch (result) {
        case TSGameModelValidSet:
            [self handleValidSetEvent];
            break;
        
        case TSGameModelInvalidSet:
            [self handleInvalidSetEvent];
            break;
            
        case TSGameModelIncompleteSet:
            return;
    }
    
    //    [self.collectionView performBatchUpdates:^{
    //        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    //        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    //    } completion:nil];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSCardCellView* deselectedCell = (TSCardCellView*) [collectionView cellForItemAtIndexPath:indexPath];
    TSCardModel* deselectedCard = [deselectedCell card];
    
    [gameModel removeFromWorkingSet:deselectedCard];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"numebrOfItems requested");
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
    [gameModel processAndReturnSolvedSet];
    NSArray* selectedItems = [collectionView indexPathsForSelectedItems];
    
    
    //    [self.collectionView performBatchUpdates:^{
    //        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    //        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    //    } completion:nil];
    
}

-(void)handleInvalidSetEventFromCollectionView:(UICollectionView*) collectionView
{
    
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
        int minutes = gameTimerSeconds / 60;
        int seconds = gameTimerSeconds % 60;
    
        NSString *timerTitle;
        timerTitle = [NSString stringWithFormat:@"%i:%02d", minutes, seconds];
    
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
    int cardsLeft = [gameModel cardsRemainingInDesk] + [cardsInPlay count];
    [statsButton setTitle:[NSString stringWithFormat:@"%d", cardsLeft]];
}

@end
