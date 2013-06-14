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
#import "TSSolvedSetProperties.h"
#import "TSSolvedSetDescriptor.h"

typedef enum {
    TSGameModelIncompleteSet = 0,
    TSGameModelValidSet = 1,
    TSGameModelInvalidSet = 2,
} TSGameModelReturnCode;

const int TSSTARTING_SIZE = 12;
const int TSMAX_BOARD_SIZE = 21;
const int TSNEXT_CARDS_SIZE = TSSET_SIZE;

@interface TSGameModel : NSObject

@property (atomic, strong, readonly) NSMutableArray* _deck;
@property (atomic, strong, readonly) NSMutableArray* _solved;
@property (atomic, strong, readonly) NSMutableArray* _board;
@property (atomic, strong, readonly) TSSetModel* _workingSet;

-(id)init;
-(NSArray*)deal;
-(NSArray*)dealNextCards;
-(bool)hasMoreCards;
-(bool)definitelyASet;
-(TSGameModelReturnCode)addToWorkingSet:(TSCardModel*) card;
-(TSSetModel*)getSolvedSet;
-(void)cancelWorkingSet;

+(NSMutableArray*)generateDeck;

@end
