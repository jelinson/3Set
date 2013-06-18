//
//  TSPlayerStatsViewController.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSPlayerStatsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *setsFoundDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *falseAlarmsDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *allDifferentSetCountDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeDiferentSetCountDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoDifferentSetCountDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneDifferentSetCountDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *noDifferentSetCountDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgTimeDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *fastestDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *slowestDetailLabel;

@end
