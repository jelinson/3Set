//
//  TSPlayerStatsViewController.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSGameModel.h"
#import "TSGameStatsModel.h"
#import "TSPlayerStatsModel.h"

@interface TSPlayerStatsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *setsFoundDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *falseAlarmsDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *avgTimeDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *fastestDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *slowestDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *allDifferentDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeDifferentDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoDifferentDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneDifferentDetailLabel;

@property (weak) TSPlayerStatsModel* playerStats;

@end
