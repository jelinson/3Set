//
//  TSSolvedSetProperties.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSSolvedSetDescriptor.h"

@interface TSSolvedSetProperties : NSObject

@property (atomic, assign) int _playerID;
@property (atomic, assign) NSTimeInterval _timeToFind;
@property (atomic, assign) TSSolvedSetDescription _desc;

-(id)initWithPlayer:(int)playerID andTime:(NSTimeInterval)timeToFind andDesciption:(TSSolvedSetDescription) desc;

@end
