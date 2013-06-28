//
//  TSSolvedSetProperties.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSSolvedSetProperties.h"

@implementation TSSolvedSetProperties

@synthesize _desc, _playerID, _timeToFind;

-(id) initWithPlayer:(int)playerID andTime:(NSTimeInterval)timeToFind andDesciption:(TSSolvedSetDescription)desc
{
    self = [super init];
    if (self) {
        _playerID = playerID;
        _timeToFind = timeToFind;
        _desc = desc;
    } else {
        NSLog(@"ERROR: Could not initialize SolveSetProperties");
    }
    return self;
}

@end
