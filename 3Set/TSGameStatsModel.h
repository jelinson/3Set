//
//  TSGameStatsModel.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.18..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSGameStatsModel : NSObject

@property NSMutableArray* solvedSetProperties;
@property NSMutableArray* playerStats;
@property (assign) int nPlayers;
@property (assign) int totalSetsFound;
@property (assign) int cardsLeft;
@property (assign) int time;

-(id) initForPlayers:(int)numberOfPlayers;

@end
