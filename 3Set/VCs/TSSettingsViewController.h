//
//  TSSettingsViewController.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.19..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSSettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfCardsSelector;
@property (weak, nonatomic) IBOutlet UILabel *backgroundColorLabel;
@property (weak, nonatomic) IBOutlet UISwitch *hideFrameSwitch;

@end
