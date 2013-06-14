//
//  TSGameModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSGameModel.h"

@implementation TSGameModel

@synthesize _deck, _solved, _board, _workingSet;

-(id)init
{
    self = [super init];
    if (self) {
        _deck = [TSGameModel generateDeck];
        _solved = [NSMutableArray array];
        _board = [NSMutableArray array];
        _workingSet = [[TSSetModel alloc] init];
    } else {
        NSLog(@"ERROR: Could not initialize game object");
    }
    
    return self;
}

-(NSArray*)deal
{
    for (int i = 0; i < TSSTARTING_SIZE; ++i) {
        [_board addObject:[self nextCardFromDeck]];
    }
    return _board;
}

-(NSArray*)dealNextCards
{
    NSMutableArray* nextCards = [NSMutableArray arrayWithCapacity:TSNEXT_CARDS_SIZE];
    for (int i = 0; i < TSNEXT_CARDS_SIZE; ++i) {
        TSCardModel* card = [self nextCardFromDeck];
        [_board addObject:card];
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
    if (_workingSet == Nil) {
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

-(TSSetModel*) getSolvedSet
{
    if (![_workingSet isValid]) {
        NSLog(@"WARNING: Requesting solved set when current set is invalid");
        return Nil;
    }
    
    TSSetModel* savedSolvedSet = [_workingSet copy];
    [_solved addObject:savedSolvedSet];
    _workingSet = Nil;
    
    return savedSolvedSet;
}

-(void) cancelWorkingSet
{
    _workingSet = Nil;
}

-(TSCardModel*) nextCardFromDeck
{
    if (![self hasMoreCards]) {
        NSLog(@"WARNING: No cards left");
        return Nil;
    }
    
    uint32_t randomIndex = arc4random_uniform([_deck count]);
    TSCardModel* card = [_deck objectAtIndex:randomIndex];
    [_deck removeObjectAtIndex:randomIndex];
    return card;
}

+(NSMutableArray*)generateDeck
{
    NSMutableArray* deck = [NSMutableArray array];
    NSArray* possibleValues = [TSCardModel possibleValues];
    assert([possibleValues count] == TSN_ATTRIBUTE_VALUES);
    
    // TODO make this not dependent on the number of attributes
    // make a function that takes in an array and enumerates alls the combinations of appending a new value

    // first attribute
    for (int i = 0; i < TSN_ATTRIBUTE_VALUES; ++i) {
        for (int j = 0; j < TSN_ATTRIBUTE_VALUES; ++j) {
            for (int k = 0; k < TSN_ATTRIBUTE_VALUES; ++k) {
                NSNumber* first = [possibleValues objectAtIndex:i];
                NSNumber* second = [possibleValues objectAtIndex:j];
                NSNumber* third = [possibleValues objectAtIndex:k];
                
                NSArray* cardValues = [NSArray arrayWithObjects:first, second, third, nil];
                
                TSCardModel* card = [[TSCardModel alloc] initWithValues:cardValues];
                
                [deck addObject:card];
            }
        }
    }
    
    return deck;
}

@end
