//
//  ViewController.m
//  1简单工厂模式
//
//  Created by 黄成都 on 15/8/10.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "SimpleFactoryVCtrl.h"
#import "HCDCalcuteFactory.h"
@interface SimpleFactoryVCtrl ()
@property (weak, nonatomic) IBOutlet UITextField *numberA;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberB;
@property (weak, nonatomic) IBOutlet UILabel *resultTextfield;

@end

@implementation SimpleFactoryVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)calculate:(id)sender {
    id<HCDCalculate> cal;
    
    cal =[HCDCalcuteFactory createCalcute:self.countTextField.text];
    cal.numberA = [self.numberA.text floatValue];
    cal.numberB = [self.numberB.text floatValue];
    CGFloat result =  [cal calculate];
    //NSLog(@"结%@")
    self.resultTextfield.text = [@(result) stringValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
