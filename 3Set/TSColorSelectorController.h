//
//  TSColorSelectorController.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSColorSelectorController : UITableViewController

@property (assign) int selectedRow;
@property (strong, readonly) NSMutableArray* colorSelection;

@end
