//
//  MyCell.m
//  MVCDemo-OC
//
//  Created by xyxxllh on 16/7/27.
//  Copyright © 2016年 XunLei. All rights reserved.
//

#import "MVCMyCell.h"
#import "NSObject+MVCModel.h"
#import "UIView+MVCModel.h"
#import "MVCCellModel.h"

@interface MVCMyCell()
@property (weak, nonatomic) IBOutlet UILabel *hitLabel;

@end

@implementation MVCMyCell

- (BOOL)update:(id<TTModel>)model{
    if ([model isKindOfClass:[MVCCellModel class]]) {
        MVCCellModel *m = model;
        self.hitLabel.text = [m hit];
        return YES;
    }
    return NO;
}

@end
