//
//  TSSetModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSSetModel.h"

const int TSSET_SIZE = 3;

@implementation TSSetModel

@synthesize desc;
@synthesize isValid = _isValid;
@synthesize cards = _cards;

-(id)init
{
    self = [super init];
    if (self) {
        _count = 0;
        _nDifferent = 0;
        _cards = [NSMutableArray arrayWithCapacity:TSSET_SIZE];
    } else {
        NSLog(@"ERROR: Could not initialize SetModel");
    }

    return self;
}

-(void)addCard:(TSCardModel *)card
{
    if (![self isFull]) {
        _cards[_count] = card;
        ++_count;
        
        if ([self isFull]) {
            [self validate];
        }
    } else {
        NSLog(@"WARNING: Adding to a full set; ignoring");
    }
}

-(bool)removeCard:(TSCardModel *)card
{
    // TODO: possible error when checking for equality
    if ([_cards containsObject:card]) {
        [_cards removeObject:card];
        --_count;
        return true;
    } else {
        return false;
    }
}

-(bool)isFull
{
    return _count == TSSET_SIZE;
}

-(void)validate
{
    desc = TSSolvedSetNoDifferent;
    for (int i = 0; i < TSN_ATTRIBUTE_TYPES; ++i) {
        int same = ~0;
        int diff = 0;
        for (int j = 0; j <TSSET_SIZE; ++j) {
            same &= [_cards[j] getValueOfAttribute:i];
            diff |= [_cards[j] getValueOfAttribute:i];
        }
        
        if (diff == TSALL_DIFFERENT_MASK) {
            desc +=1;
            continue;
        } else if (same) {
            continue;
        } else {
            _isValid = false;
            return;
        }
    }
    _isValid = true;
}

-(NSMutableArray*)sortedIndicesInGameBoardOfSet
{
    assert(_isValid);
    NSMutableArray* indices = [NSMutableArray arrayWithCapacity:TSSET_SIZE];
    
    for (TSCardModel* card in _cards) {
        [indices addObject:[NSNumber numberWithInt:[card indexInGameBoard]]];
    }
    [indices sortUsingSelector:@selector(compare:)];
    return indices;
}

@end
