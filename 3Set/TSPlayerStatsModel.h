//
//  TSPlayerStatsModel.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.18..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSSolvedSetProperties.h"

@interface TSPlayerStatsModel : NSObject

@property (readonly, assign) int pid;
@property (readonly, assign) int setsFound;
@property (readonly, assign) int falseAlarms;
@property (readonly, retain) NSMutableArray* setTypeCount;
@property (readonly, assign) double fastestTime;
@property (readonly, assign) double totalTime;
@property (readonly, assign) double slowestTime;

-(id) initWithId:(int) playerID;
-(void) processNextSolvedSetProperty:(TSSolvedSetProperties*) properties;
-(int) computeScore;
-(double) computeTime;
-(int) countForType:(TSSolvedSetDescription) type;
-(void) addFalseAlarm;

@end
