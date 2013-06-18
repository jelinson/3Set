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

@synthesize pid, setsFound, falseAlarms, setTypeCount, fastestTime, totalTime, slowestTime;

-(id) initWithId:(int) playerID
{
    self = [super init];
    if (self) {
        pid = playerID;
        setTypeCount = [NSMutableArray arrayWithCapacity:TSNumberOfSolvedSetTypes];
        for (int i = 0; i < TSNumberOfSolvedSetTypes; ++i) {
            NSNumber* zero = [NSNumber numberWithInt:0];
            [setTypeCount addObject:zero];
        }
        
        fastestTime = INFINITY;
    } else {
        NSLog(@"ERROR: Could not initialize PlayerStatsModel");
    }
    return self;
}

-(void) processNextSolvedSetProperty:(TSSolvedSetProperties*) properties
{
    assert([properties _playerID] == pid);
    double time = (double) [properties _timeToFind];
    fastestTime = MIN(fastestTime, time);
    slowestTime = MAX(slowestTime, time);
    totalTime += time;
    ++setsFound;
    
    // this feels sketchy
    int type = [properties _desc];
    NSNumber* count = [setTypeCount objectAtIndex:type];
    NSNumber* incrementedCount = [NSNumber numberWithInt:([count intValue] + 1)];
    [setTypeCount replaceObjectAtIndex:type withObject:incrementedCount];
}

-(int) computeScore
{
    return setsFound - falseAlarms;
}

-(double) computeTime
{
    return totalTime / (double) setsFound;
}

@end
