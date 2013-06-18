//
//  TSGameModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSGameModel.h"

const int TSSTARTING_SIZE = 12;
const int TSMAX_BOARD_SIZE = 21;
const int TSNEXT_CARDS_SIZE = 3;

@implementation TSGameModel

@synthesize _nPlayers, _deck, _solved, _board, _workingSet, _lastSetIndices;

-(id)initForPlayers:(int) numberOfPlayers
{
    self = [super init];
    if (self) {
        _deck = [TSGameModel generateDeck];
        _solved = [NSMutableArray array];
        _board = [NSMutableArray array];
        _workingSet = [[TSSetModel alloc] init];
        _nPlayers = numberOfPlayers;
        _gameStats = [[TSGameStatsModel alloc] initForPlayers:_nPlayers];
    } else {
        NSLog(@"ERROR: Could not initialize game object");
    }
    
    return self;
}

-(NSArray*)deal
{
    for (int i = 0; i < TSSTARTING_SIZE; ++i) {
        TSCardModel* card = [self nextCardFromDeck];
        [card setIndexInGameBoard:[_board count]];
        [_board addObject:card];
    }
    return _board;
}

-(NSArray*)dealNextCardsExtra:(BOOL)extra
{
    NSMutableArray* nextCards = [NSMutableArray arrayWithCapacity:TSNEXT_CARDS_SIZE];
    for (int i = 0; i < MIN(TSNEXT_CARDS_SIZE, [_deck count]); ++i) {
        TSCardModel* card = [self nextCardFromDeck];
        if (extra) {
            [card setIndexInGameBoard:[_board count]];
            [_board addObject:card];
        } else {
            assert([_lastSetIndices count] > 0);
            int replacementIndex = [[_lastSetIndices objectAtIndex:0] intValue];
            [card setIndexInGameBoard:replacementIndex];
            [_board insertObject:card atIndex:replacementIndex];
            [_lastSetIndices removeObjectAtIndex:0];
        }
        [nextCards addObject:card];
    }
    return nextCards;
}

-(bool) hasMoreCards
{
    return [_deck count];
}

-(bool) definitelyASet
{
    return [_board count] >= TSMAX_BOARD_SIZE;
}

-(TSGameModelReturnCode)addToWorkingSet:(TSCardModel *)card
{
    if (_workingSet == nil) {
        _workingSet = [[TSSetModel alloc] init];
    }
    
    [_workingSet addCard:card];
    if ([_workingSet isFull]) {
        if ([_workingSet isValid]) {
            return TSGameModelValidSet;
        } else {
            return TSGameModelInvalidSet;
        }
    } else {
        return TSGameModelIncompleteSet;
    }
}

-(void)removeFromWorkingSet:(TSCardModel *)card
{
    bool cardWasPresent = [_workingSet removeCard:card];
    if (!cardWasPresent)
        NSLog(@"WARNING: Tried to remove an invalid card from a set");
}

-(TSSetModel*) processAndReturnSolvedSet
{
    if (![_workingSet isValid]) {
        NSLog(@"WARNING: Requesting solved set when current set is invalid");
        return nil;
    }

    TSSetModel* savedSolvedSet = _workingSet;
    [_solved addObject:savedSolvedSet];
    
    _lastSetIndices = [_workingSet sortedIndicesInGameBoardOfSet];
    
    for (TSCardModel* card in [_workingSet cards]) {
        [_board removeObject:card];
    }
    
    _workingSet = nil;
    
    return savedSolvedSet;
}

-(void) cancelWorkingSet
{
    _workingSet = nil;
}

-(TSCardModel*) nextCardFromDeck
{
    if (![self hasMoreCards]) {
        NSLog(@"WARNING: No cards left");
        return nil;
    }
    
    uint32_t randomIndex = arc4random_uniform([_deck count]);
    TSCardModel* card = [_deck objectAtIndex:randomIndex];
    [_deck removeObjectAtIndex:randomIndex];

    return card;
}

-(int)cardsRemainingInDesk
{
    return [_deck count];
}

-(int)cardsInPlayCount
{
    return [_board count];
}

+(NSMutableArray*)generateDeck
{
    NSMutableArray* deck = [NSMutableArray array];
    NSArray* possibleValues = [TSCardModel possibleValues];
    assert([possibleValues count] == TSN_ATTRIBUTE_VALUES);
    
    // TODO make this not dependent on the number of attributes
    // make a function that takes in an array and enumerates alls the combinations of appending a new value

    
    for (int i = 0; i < TSN_ATTRIBUTE_VALUES; ++i) {
        for (int j = 0; j < TSN_ATTRIBUTE_VALUES; ++j) {
            for (int k = 0; k < TSN_ATTRIBUTE_VALUES; ++k) {
                for (int l = 0; l < TSN_ATTRIBUTE_VALUES; ++l) {
                    NSNumber* first = [possibleValues objectAtIndex:i];
                    NSNumber* second = [possibleValues objectAtIndex:j];
                    NSNumber* third = [possibleValues objectAtIndex:k];
                    NSNumber* fourth = [possibleValues objectAtIndex:l];
                    
                    NSArray* cardValues = [NSArray arrayWithObjects:first, second, third, fourth, nil];
                    
                    assert([cardValues count] == TSN_ATTRIBUTE_TYPES);
                    
                    TSCardModel* card = [[TSCardModel alloc] initWithValues:cardValues];
                    
                    [deck addObject:card];
                }
            }
        }
    }
    
    return deck;
}

+(TSGameModel*)getGameInstanceForPlayers:(int) nPlayers
{
    static TSGameModel* currentSinglePlayerGame = nil;
    static TSGameModel* currentMultiplayerGame = nil;
    
    if (nPlayers == 1) {
        if (currentSinglePlayerGame == nil) {
            currentSinglePlayerGame = [[TSGameModel alloc] initForPlayers:nPlayers];
        }
        return currentSinglePlayerGame;
    } else {
        NSLog(@"WARNING: Multiplayer not yet implemented");
        if (currentMultiplayerGame == nil) {
            currentMultiplayerGame = [[TSGameModel alloc] initForPlayers:nPlayers];
        }
        return currentMultiplayerGame;
    }
}

@end
