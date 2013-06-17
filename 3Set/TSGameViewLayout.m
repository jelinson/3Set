//
//  TSGameViewLayout.m
//  3Set
//
//  Created by Julius Elinson on 2013.06.17..
//  Copyright (c) 2013 AIT. All rights reserved.
//

#import "TSGameViewLayout.h"
#import "TSGameModel.h"

@implementation TSGameViewLayout

const int TSREG_CELL_H = 100;
const int TSREG_CELL_W = 75;
const int TSREG_ROW_SPACING = 12;
const int TSREG_COL_SPACING = 6;
const int TSREG_CELLS_PER_ROW = 3;

const int TSSM_CELL_H = 50;
const int TSSM_CELL_W = 38;
const int TSSM_ROW_SPACING = 8;
const int TSSM_COL_SPACING = 4;
const int TSSM_CELLS_PER_ROW = 4;

const int TSXSM_CELL_H = 25;
const int TSXSM_CELL_W = 19;
const int TSXSM_ROW_SPACING = 6;
const int TSXSM_COL_SPACING = 4;
const int TSXSM_CELLS_PER_ROW = 4;

const int TSSM_SIZE_THRESHOLD = 15;
const int TSXSM_SIZE_THRESHOLD = 18;

@synthesize currentCellH, currentCellW, currentCellPerRow, currentRowSpacing, currentColSpacing;
@synthesize nCardsInPlay, boardSize;
@synthesize topSectionInsert, bottomSectionInsert, leftSectionInsert, rightSectionInsert;
@synthesize layoutH, layoutW;

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
    
    // todo: this should probably be passed (in cases such as resuming cases)
    // let's see if this will handle it all
    [self updateBoardSize:TSSTARTING_SIZE];
}

-(void) updateCurrentDimensions;
{
    if (boardSize == TSXSM_SIZE) {
        NSLog(@"Using xsm size");
        currentCellH = TSXSM_CELL_H;
        currentCellW = TSXSM_CELL_W;
        currentRowSpacing = TSXSM_ROW_SPACING;
        currentColSpacing = TSXSM_COL_SPACING;
        currentCellPerRow = TSXSM_CELLS_PER_ROW;
    } else if (boardSize == TSSM_SIZE) {
        NSLog(@"Using sm size");
        currentCellH = TSSM_CELL_H;
        currentCellW = TSSM_CELL_W;
        currentRowSpacing = TSSM_ROW_SPACING;
        currentColSpacing = TSSM_COL_SPACING;
        currentCellPerRow = TSSM_CELLS_PER_ROW;
    } else {
        NSLog(@"Using reg size");
        currentCellH = TSREG_CELL_H;
        currentCellW = TSREG_CELL_W;
        currentRowSpacing = TSREG_ROW_SPACING;
        currentColSpacing = TSREG_COL_SPACING;
        currentCellPerRow = TSREG_CELLS_PER_ROW;
    }
}

-(BOOL) updateBoardSize:(int) newSize
{
    int tmpOldNCardsInPlay = self.nCardsInPlay;
    self.nCardsInPlay = newSize;
    TSBOARD_SIZE_T newSizeType;
    
    if (newSize >= TSXSM_SIZE_THRESHOLD) {
        newSizeType = TSXSM_SIZE;
    } else if (newSize >= TSSM_SIZE_THRESHOLD) {
        newSizeType = TSSM_SIZE;
    }  else {
        newSizeType = TSREG_SIZE;
    }
    
    if (newSizeType != self.boardSize || tmpOldNCardsInPlay == 0) {
        NSLog([NSString stringWithFormat: @"Board size changed from %d to %d", tmpOldNCardsInPlay, newSize]);
        self.boardSize = newSizeType;
        [self updateCurrentDimensions];
        return true;
    }
    return false;
}

-(void) prepareLayout
{
    NSLog(@"prepareLayout in");
    [self computeTotalLayoutDimensions];
    NSLog(@"prepareLayout out");
}

-(void) computeTotalLayoutDimensions
{
    NSLog(@"computeTotalLayoutDimensions in");
    layoutW = 0;
    layoutH = 0;
    
    layoutH += topSectionInsert;
    layoutH += bottomSectionInsert;
    layoutW += rightSectionInsert;
    layoutW += leftSectionInsert;

    // ceil
    int nRows = (nCardsInPlay + currentCellPerRow + 1) / currentCellPerRow;
    int nCols = currentCellPerRow;
    
    layoutH += (nRows * currentCellH);
    layoutH += ((nRows - 1) * currentRowSpacing);
    
    layoutW += (nCols * currentCellW);
    layoutW += ((nCols - 1) * currentColSpacing);
    
    NSLog([NSString stringWithFormat:@"Layout size: %d x %d", layoutW, layoutH]);
    NSLog(@"computeTotalLayoutDimensions out");
}

-(CGSize)collectionViewContentSize
{
    NSLog(@"collectionViewContentSize in");
    CGSize layoutSize;
    layoutSize.height = (CGFloat) layoutH;
    layoutSize.width =  (CGFloat) layoutW;
    NSLog([NSString stringWithFormat:@"Layout size: %.2lf x %.2lf", layoutSize.width, layoutSize.height]);
    NSLog(@"collectionViewContentSize out");
    return layoutSize;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"layoutAttributesForElementsInRect in");
    NSMutableArray* attributesForElementsInRect = [NSMutableArray array];
    for (int i = 0; i < nCardsInPlay; ++i) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (!CGRectIsNull(CGRectIntersection(rect, [attributes frame]))) {
            [attributesForElementsInRect addObject:attributes];
        }
    }
    NSLog(@"layoutAttributesForElementsInRect out");
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
