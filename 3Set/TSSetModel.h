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

const int TSSET_SIZE = 3;

@interface TSSetModel : NSObject {
    TSCardModel* _cards[TSSET_SIZE];
    int _count;
    int _nDifferent;
}

@property (atomic, assign) bool _isValid;
@property (atomic, assign) TSSolvedSetDescription _desc;


-(id)init;
-(void)addCard:(TSCardModel*) card;
-(bool)isFull;

@end
