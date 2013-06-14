//
//  TSSetModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSSetModel.h"

@implementation TSSetModel

@synthesize isValid = _isValid;

-(id)init
{
    self = [super init];
    if (self) {
        _count = 0;
        _nDifferent = 0;
        // TODO: Check if _cards is initialized properly;
    } else {
        NSLog(@"ERROR: Could not initialize SetModel");
    }

    return self;
}

-(void)addCard:(TSCardModel *)card
{
    if (![self isFull]) {
        _cards[_count] = [card copy];
        ++_count;
        
        if ([self isFull]) {
            [self validate];
        }
    } else {
        NSLog(@"WARNING: Adding to a full set; ignoring");
    }
}

-(bool)isFull
{
    return _count == TSSET_SIZE;
}

-(void)validate
{
    _nDifferent = 0;
    for (int i = 0; i < TSN_ATTRIBUTE_TYPES; ++i) {
        int same = ~0;
        int diff = 0;
        for (int j = 0; j <TSSET_SIZE; ++j) {
            same &= [_cards[j] getValueOfAttribute:i];
            diff |= [_cards[j] getValueOfAttribute:i];
        }
        
        if (diff == TSALL_DIFFERENT_MASK) {
            _nDifferent +=1;
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

@end
