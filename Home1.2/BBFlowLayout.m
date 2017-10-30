//
//  BBFlowLayout.m
//  ChartViewDemo
//
//  Created by yuyue on 16/11/16.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import "BBFlowLayout.h"

/** 默认列数 */
static const NSInteger JGDefaultColumnCount = 1;
/** 每一列之间的间距 */
static const NSInteger JGDefaultColumnMargin = 10;
/** 默认列数 */
static const NSInteger JGDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets JGDefaultEdgeInsets = {10, 10, 10, 10};

/** cell 大小 */
static const CGSize JGDefaultSize = {10, 10};

@interface BBFlowLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;


- (NSInteger)columnCount;

- (UIEdgeInsets)edgeInsets;
- (CGSize)cellSize;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;

@end


@implementation BBFlowLayout



- (NSInteger)columnCount {
    
    if ([self.delegate respondsToSelector:@selector(columnCountInBBflowLayout:)]) {
        return [self.delegate columnCountInBBflowLayout:self];
    }else {
        return JGDefaultColumnCount;
    }
}


- (CGSize)cellSize {
    
    if ([self.delegate respondsToSelector:@selector(sizeInBBflowLayout:)]) {
        return [self.delegate sizeInBBflowLayout:self];
    }else {
        return JGDefaultSize;
    }
}

- (CGFloat)columnMargin {
    
    if ([self.delegate respondsToSelector:@selector(columnMarginInBBflowLayout:)]) {
        return [self.delegate columnMarginInBBflowLayout:self];
    }else {
        return JGDefaultColumnMargin;
    }
}

- (CGFloat)rowMargin {
    
    if ([self.delegate respondsToSelector:@selector(rowMarginInBBflowLayout:)]) {
        return [self.delegate rowMarginInBBflowLayout:self];
    }else {
        return JGDefaultRowMargin;
    }
}


- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInBBflowLayout:)]) {
        return [self.delegate edgeInsetsInBBflowLayout:self];
    }else {
        return JGDefaultEdgeInsets;
    }
}




- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}



- (void)prepareLayout {
    
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    
    
    UICollectionViewLayoutAttributes * layoutHeader = [UICollectionViewLayoutAttributes   layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    layoutHeader.frame =CGRectMake(0, 0, SCREEM_WIDTH, 300);
    [_attrsArray addObject:layoutHeader];
    
 

    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
    
}

/**
 *  决定cell的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attrsArray;
}


//cell 的属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //collectionView的宽度
//    CGFloat collectionViewW = self.collectionView.frame.size.width;

    NSInteger page = indexPath.row;
    
    CGFloat width = self.cellSize.width;
    CGFloat height = self.cellSize.height;
    
    
    CGFloat x = self.edgeInsets.left + (self.columnMargin + width) *(page%self.columnCount);
    
//    CGFloat  ss = self.rowMargin;
    
    CGFloat y = self.edgeInsets.top + (self.rowMargin + height) *(page/self.columnCount);
    
    attrs.frame = CGRectMake(x, y, width, height);
    
    
    return attrs ;
}


//collectionView 滑动区域
- (CGSize)collectionViewContentSize {
    
    UICollectionViewLayoutAttributes *attrs = self.attrsArray.lastObject;
    
    CGFloat height = CGRectGetMinY(attrs.frame) + CGRectGetHeight(attrs.frame) +self.self.edgeInsets.bottom;
    
    return CGSizeMake(0, height);
}



@end
