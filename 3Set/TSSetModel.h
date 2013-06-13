//
//  TSSetModel.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCardModel.h"

const int TSSET_SIZE = 3;

@interface TSSetModel : NSObject {
    TSCardModel* cards[TSSET_SIZE];
    int count;
}

@property (atomic, assign) bool isValid;

-(void)addCard:(TSCardModel*) card;
-(bool)isFull;

@end
