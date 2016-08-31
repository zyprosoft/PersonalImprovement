//
//  StructureAndPatternVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "StructureAndPatternVCtrl.h"
#import "ReactiveCocoaMVVMVCtrl.h"

#import "AbstractFactoryViewController.h"
#import "BridgeViewController.h"
#import "BuilderViewController.h"
#import "ChainOfResponsibilityViewController.h"
#import "DecoratorViewController.h"
#import "FacadeViewController.h"
#import "FlyweightViewController.h"
#import "MySingleton.h"
#import "PatternSingleton.h"
#import "StrategyViewController.h"
#import "TemplateMethodViewController.h"
#import "CoordinatingController.h"

@interface StructureAndPatternVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation StructureAndPatternVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"MVC&MVVM&MVP&VIPPER比较" class:@"StructureVCtrl"];
    [self addCell:@"MVVM&ReactiveCocoa" class:@"ReactiveCocoaMVVMVCtrl"];
    [self addCell:@"Pattern" class:@"PatternVCtrl"];
    
    [self addCell:@"Objective-C设计模式-AbstractFactory" class:@"AbstractFactoryViewController"];
    [self addCell:@"Objective-C设计模式-Bridge" class:@"BridgeViewController"];
    [self addCell:@"Objective-C设计模式-Builder" class:@"BuilderViewController"];
    [self addCell:@"Objective-C设计模式-ChainOfResponsibility" class:@"ChainOfResponsibilityViewController"];
    [self addCell:@"Objective-C设计模式-Decorator" class:@"DecoratorViewController"];
    [self addCell:@"Objective-C设计模式-Facade" class:@"FacadeViewController"];
    [self addCell:@"Objective-C设计模式-Flyweight" class:@"FlyweightViewController"];
    [self addCell:@"Objective-C设计模式-Strategy" class:@"StrategyViewController"];
    [self addCell:@"Objective-C设计模式-TemplateMethod" class:@"TemplateMethodViewController"];
    [self addCell:@"Objective-C设计模式-Singleton" class:@"ddd"];
    [self addCell:@"Objective-C设计模式-TouchPainter" class:@"ddd"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.titleArray[indexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = self.titleArray[indexPath.row];
    NSString *classStr = self.classArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    UIViewController *ctrl = [[class alloc]init];
    ctrl.title = cellTitle;
    if ([cellTitle isEqualToString:@"Objective-C设计模式-Singleton"]) {
        PatternSingleton *s = [MySingleton sharedInstance];
        [s operation];
    }else if ([cellTitle isEqualToString:@"Objective-C设计模式-TouchPainter"]){
        // Add the view controller's view to the window and display.
        CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
        ctrl = [coordinatingController activeViewController];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

@end
