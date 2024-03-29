//
//  TSSetModel.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCardModel.h"
#import "TSSolvedSetProperties.h"

extern const int TSSET_SIZE;

@interface TSSetModel : NSObject {
    int _count;
}

@property (atomic, assign) bool isValid;
@property (atomic, assign) TSSolvedSetDescription desc;
@property (atomic, strong, readonly) NSMutableArray* cards;


-(id)init;
-(void)addCard:(TSCardModel*) card;
-(bool)isFull;
-(bool)removeCard:(TSCardModel*) card;
-(NSMutableArray*)sortedIndicesInGameBoardOfSet;

@end
