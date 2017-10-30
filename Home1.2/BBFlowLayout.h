//
//  BBFlowLayout.h
//  ChartViewDemo
//
//  Created by yuyue on 16/11/16.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBFlowLayout;

@protocol BBFlowLayoutDelegate <NSObject>

@required

- (CGSize)sizeInBBflowLayout:(BBFlowLayout *)BBflowLayout;

@optional

// 设置列数量
- (NSInteger)columnCountInBBflowLayout:(BBFlowLayout *)BBflowLayout;

// 设置CollectionView 边框

- (UIEdgeInsets)edgeInsetsInBBflowLayout:(BBFlowLayout *)BBflowLayout;
- (CGFloat)columnMarginInBBflowLayout:(BBFlowLayout *)BBflowLayout;
- (CGFloat)rowMarginInBBflowLayout:(BBFlowLayout *)BBflowLayout;

@end

@interface BBFlowLayout : UICollectionViewFlowLayout


@property (nonatomic,assign)id <BBFlowLayoutDelegate>delegate;

@end
