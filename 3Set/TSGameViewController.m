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

@synthesize gameTimer, gameTimerLabel, statsButton, gameTimerSeconds, interfaceInteractionTimer, interfaceInteractionTimerSeconds, gameModel, cardsInPlay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // customize
    }
    
    return self;
}

- (void)initializeGame;
{
    gameModel = [[TSGameModel alloc] init];
    cardsInPlay = [gameModel deal];
    assert([cardsInPlay count] == TSSTARTING_SIZE);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeGame];
    self.collectionView.allowsMultipleSelection = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (IBAction)onBackgroundClick:(id)sender
{
    [self interfaceInteractionEvent];
}

- (void) viewDidAppear:(BOOL)animated
{
    gameTimer = [self createTimer:@selector(gameTimerTicked:)];
    [self showNavigationElements];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [gameTimer invalidate];
    [interfaceInteractionTimer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onShuffleCardsClick:(id)sender
{
    [self interfaceInteractionEvent];
}

- (IBAction)onAddCardsClick:(id)sender
{
    [self interfaceInteractionEvent];
}

// reference from
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
        timerTitle = [NSString stringWithFormat:@"Time: %i:%02d", minutes, seconds];
    
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
    return ([self isViewLoaded] && [self .view window]);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return TSSTARTING_SIZE;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TSCardCellView* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCellID" forIndexPath:indexPath];
    
    UIView* blueColorView = [[UIView alloc] init];
    [blueColorView setBackgroundColor:[UIColor blueColor]];
    [cell setSelectedBackgroundView:blueColorView];
    
    [cell setSelectedBackgroundView:blueColorView];
    [cell assignCard:[cardsInPlay objectAtIndex:[indexPath item]]];
    return cell;
}

- (void)updateStatsButton
{
    int cardsLeft = [gameModel cardsRemainingInDesk] + [cardsInPlay count];
    [statsButton setTitle:[NSString stringWithFormat:@"%d", cardsLeft]];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [self.collectionView performBatchUpdates:^{
//        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//    } completion:nil];
}

@end
