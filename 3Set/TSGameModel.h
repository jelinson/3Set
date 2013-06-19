//
//  TSGameModel.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSSetModel.h"
#import "TSCardModel.h"
#import "TSGameStatsModel.h"
#import "TSSolvedSetProperties.h"
#import "TSSolvedSetDescriptor.h"

typedef enum {
    TSGameModelIncompleteSet = 0,
    TSGameModelValidSet = 1,
    TSGameModelInvalidSet = 2,
} TSGameModelReturnCode;

extern const int TSMAX_BOARD_SIZE;
extern const int TSNEXT_CARDS_SIZE;

@interface TSGameModel : NSObject

@property (assign) int _nPlayers;
@property (assign, readonly) int startingSize;
@property (atomic, strong, readonly) NSMutableArray* _deck;
@property (atomic, strong, readonly) NSMutableArray* _solved;
@property (atomic, strong, readonly) NSMutableArray* _board;
@property (atomic, strong, readonly) TSSetModel* _workingSet;
@property (atomic, strong, readonly) NSMutableArray* _lastSetIndices;
@property (strong, readwrite) TSGameStatsModel* gameStats;

-(id)initForPlayers:(int) numberOfPlayers;
-(NSArray*)deal;
-(NSArray*)dealNextCardsExtra:(BOOL)extra;
-(bool)hasMoreCards;
-(bool)definitelyASet;
-(TSGameModelReturnCode)addToWorkingSet:(TSCardModel*) card;
-(void)removeFromWorkingSet:(TSCardModel*) card;
-(TSSetModel*)processAndReturnSolvedSet;
-(void)cancelWorkingSet;
-(int)cardsRemainingInDesk;
-(int)cardsInPlayCount;


+(NSMutableArray*)generateDeck;
+(TSGameModel*)getGameInstanceForPlayers:(int) nPlayers andClear:(BOOL)clear;

@end
