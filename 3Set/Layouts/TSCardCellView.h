//
//  TSCardCellView.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.15..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSCardModel.h"

@interface TSCardCellView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, readwrite) TSCardModel* card;

@property (strong) UIImage* imgSrc;
@property (strong) NSMutableString* imgPath;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

-(void)assignCard:(TSCardModel *)card;

@end
