//
//  TSPlayerStatsModel.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.18..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSPlayerStatsModel.h"
#import "TSSolvedSetDescriptor.h"

@implementation TSPlayerStatsModel

@synthesize pid, setsFound, falseAlarms, setTypeCount, fastestTime, avgTime, slowestTime;

-(id) initWithId:(int) playerID
{
    self = [super init];
    if (self) {
        pid = playerID;
        setTypeCount = [NSMutableArray arrayWithCapacity:TSNumberOfSolvedSetTypes];
        fastestTime = INFINITY;
    } else {
        NSLog(@"ERROR: Could not initialize PlayerStatsModel");
    }
}
-(void) processNextSolvedSetProperty:(TSSolvedSetProperties*) properties
{
    // todo: implement meee
}

@end
