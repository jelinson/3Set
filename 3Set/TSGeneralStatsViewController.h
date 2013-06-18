//
//  TSGeneralStatsViewController.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSGeneralStatsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *totalSetsFoundDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardsLeftDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *possibleSetsLeftDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreDetailLabel;



@end
