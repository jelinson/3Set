//
//  TSGameViewLayout.h
//  3Set
//
//  Created by Julius Elinson on 2013.06.17..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const int TSREG_CELL_H, TSREG_CELL_W, TSREG_CARDS_PER_ROW;
extern const int TSSM_CELL_H, TSSM_CELL_W, TSSM_CARDS_PER_ROW;
extern const int TSXSM_CELL_H, TSXSM_CELL_W, TSXSM_CARDS_PER_ROW;
extern const int TSSM_SIZE_THRESHOLD;
extern const int TSXSM_SIZE_THRESHOLD;

typedef enum {
    TSREG_SIZE = 0,
    TSSM_SIZE = 1,
    TSXSM_SIZE = 2
} TSBOARD_SIZE_T;

@interface TSGameViewLayout : UICollectionViewLayout

@property (assign) int nCardsInPlay;
@property (assign) int currentCellH, currentCellW, currentCellPerRow, currentRowSpacing, currentColSpacing;
@property (assign) int nRows, nCols;
@property (assign) int topSectionInsert, bottomSectionInsert, leftSectionInsert, rightSectionInsert;
@property (assign) int layoutW, layoutH, screenW, screenH;

@property (assign) TSBOARD_SIZE_T boardSize;

-(BOOL) updateBoardSize:(int) newSize;

@end
