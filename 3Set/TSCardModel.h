//
//  TSCardModel.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.12..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSAttributeModel.h"

@interface TSCardModel : NSObject

@property (strong, atomic, readonly) NSArray *attributes;

-(id) init;
-(NSInteger) getUniqueID;

@end
