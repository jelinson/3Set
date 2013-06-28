//
//  TSGameStatsModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.18..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSGameStatsModel.h"

@implementation TSGameStatsModel

@synthesize solvedSetProperties, playerStats, nPlayers, totalSetsFound, cardsLeft, time;

-(id) initForPlayers:(int)numberOfPlayers
{
    self = [super init];
    if (self) {
        nPlayers = numberOfPlayers;
        solvedSetProperties = [NSMutableArray array];
        playerStats = [NSMutableArray arrayWithCapacity:nPlayers];
    
        for (int i = 0; i < nPlayers; ++i) {
            [playerStats addObject:[[TSPlayerStatsModel alloc] initWithId:i]];
        }
    } else {
        NSLog(@"ERROR: Could not initialize game stats");
    }
    
    return self;
}

-(void) updateJustInTime:(int)seconds andCards:(int)nCards
{
    time = seconds;
    cardsLeft = nCards;
}

-(void) processSolvedSet:(TSSolvedSetProperties *)setProperties
{
    ++totalSetsFound;
    int player = [setProperties _playerID];
    [[playerStats objectAtIndex:player] processNextSolvedSetProperty:setProperties];
}

-(int) playerScore:(int)playerId
{
    return  [[playerStats objectAtIndex:playerId] computeScore];
}

-(void) processInvalidSet:(int)playerID
{
    [[playerStats objectAtIndex:playerID] addFalseAlarm];
}

@end
