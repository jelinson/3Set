//
//  TSCardAttributes.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.13..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSAttributeModel.h"

@interface TSCardAttributes : NSObject {
    TSAttributeModel* attributes[TSN_ATTRIBUTES];
}

-(TSAttributeValue) getValueForAttribute:(TSAttributeType) type;

@end
