//
//  BaseChartView.h
//  memoryTest
//
//  Created by user on 2018/5/16.
//  Copyright © 2018年 tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseChartView : UIView


-(void)updateDataArray:(NSArray*)arr;

/* */
@property (assign, nonatomic) CGFloat minValue,maxValue;

/* */
@property (strong, nonatomic) UILabel *titleLab;

@end
