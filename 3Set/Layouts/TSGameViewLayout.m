//
//  TSGameViewLayout.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.17..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSGameViewLayout.h"
#import "TSGameModel.h"
#import "TSSettingManager.h"

@implementation TSGameViewLayout

const int TSREG_CELL_H = 100;
const int TSREG_CELL_W = 75;
const int TSREG_CELLS_PER_ROW = 3;

const int TSSM_CELL_H = 75;
const int TSSM_CELL_W = 57;
const int TSSM_CELLS_PER_ROW = 3;

const int TSXSM_CELL_H = 65;
const int TSXSM_CELL_W = 49;
const int TSXSM_CELLS_PER_ROW = 3;

const int TSSM_SIZE_THRESHOLD = 15;
const int TSXSM_SIZE_THRESHOLD = 18;

@synthesize currentCellH, currentCellW, currentCellPerRow, currentRowSpacing, currentColSpacing;
@synthesize nRows, nCols;
@synthesize nCardsInPlay, boardSize;
@synthesize topSectionInsert, bottomSectionInsert, leftSectionInsert, rightSectionInsert;
@synthesize layoutH, layoutW, screenW, screenH;

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeLayout];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeLayout];
    }
    return self;
}

-(void)initializeLayout
{
    topSectionInsert = 55;
    bottomSectionInsert = 55;
    leftSectionInsert = 20;
    rightSectionInsert = 20;
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    screenW = (int) screenRect.size.width;
    screenH = (int) screenRect.size.height;
    
    // TODO: this should be set somewhere, in cases where a game is resuming
    [self updateBoardSize: [[TSSettingManager getSettingManagerInstance] numberOfCards]];
    
}

-(void) updateCurrentDimensions;
{
    if (boardSize == TSXSM_SIZE) {
        NSLog(@"Using xsm size");
        currentCellH = TSXSM_CELL_H;
        currentCellW = TSXSM_CELL_W;
        currentCellPerRow = TSXSM_CELLS_PER_ROW;
    } else if (boardSize == TSSM_SIZE) {
        NSLog(@"Using sm size");
        currentCellH = TSSM_CELL_H;
        currentCellW = TSSM_CELL_W;
        currentCellPerRow = TSSM_CELLS_PER_ROW;
    } else {
        NSLog(@"Using reg size");
        currentCellH = TSREG_CELL_H;
        currentCellW = TSREG_CELL_W;
        currentCellPerRow = TSREG_CELLS_PER_ROW;
    }
    [self calculateGridDimensions];
    [self calculateCurrentSpacing];
}

-(void) calculateGridDimensions
{
    // ceiling
    nRows = (nCardsInPlay + currentCellPerRow - 1) / currentCellPerRow;
    nCols = currentCellPerRow;
}

-(void) calculateCurrentSpacing
{
    currentColSpacing = MAX(0, (screenW - leftSectionInsert - rightSectionInsert - nCols * currentCellW) / (nCols - 1));
    currentRowSpacing = MAX(0, (screenH - topSectionInsert - bottomSectionInsert - nRows * currentCellH) / (nRows - 1));
}

-(BOOL) updateBoardSize:(int) newSize
{
    int tmpOldNCardsInPlay = self.nCardsInPlay;
    nCardsInPlay = newSize;
    TSBOARD_SIZE_T newSizeType;
    
    if (newSize >= TSXSM_SIZE_THRESHOLD) {
        newSizeType = TSXSM_SIZE;
    } else if (newSize >= TSSM_SIZE_THRESHOLD) {
        newSizeType = TSSM_SIZE;
    }  else {
        newSizeType = TSREG_SIZE;
    }
    
    if (newSizeType != self.boardSize || tmpOldNCardsInPlay != nCardsInPlay || tmpOldNCardsInPlay == 0) {
        NSLog(@"Board size changed from %d to %d", tmpOldNCardsInPlay, newSize);
        self.boardSize = newSizeType;
        [self updateCurrentDimensions];
        return true;
    }
    return false;
}

-(void) prepareLayout
{
    [self computeTotalLayoutDimensions];
}

-(void) computeTotalLayoutDimensions
{
    layoutW = 0;
    layoutH = 0;
    
    layoutH += topSectionInsert;
    layoutH += bottomSectionInsert;
    layoutW += rightSectionInsert;
    layoutW += leftSectionInsert;
    
    layoutH += (nRows * currentCellH);
    layoutH += ((nRows - 1) * currentRowSpacing);
    
    layoutW += (nCols * currentCellW);
    layoutW += ((nCols - 1) * currentColSpacing);
}

-(CGSize)collectionViewContentSize
{
    CGSize layoutSize;
    layoutSize.height = (CGFloat) layoutH;
    layoutSize.width =  (CGFloat) layoutW;
    return layoutSize;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributesForElementsInRect = [NSMutableArray array];
    for (int i = 0; i < nCardsInPlay; ++i) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (!CGRectIsNull(CGRectIntersection(rect, [attributes frame]))) {
            [attributesForElementsInRect addObject:attributes];
        }
    }
    return attributesForElementsInRect;
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // Set cell frame
    CGRect cellFrame;
    CGPoint cellOrigin;
    CGSize cellSize;
    int cellIndex = [indexPath row];
    int cellRow = cellIndex / currentCellPerRow;
    int cellCol = cellIndex % currentCellPerRow;
    
    cellOrigin.y = (CGFloat) (topSectionInsert + cellRow * (currentCellH + currentRowSpacing));
    cellOrigin.x = (CGFloat) (leftSectionInsert + cellCol * (currentCellW + currentColSpacing));
    
    cellSize.width = (CGFloat) currentCellW;
    cellSize.height = (CGFloat) currentCellH;
    
    cellFrame.origin = cellOrigin;
    cellFrame.size = cellSize;
    
    attributes.frame = cellFrame;
    
    return attributes;
}

@end
