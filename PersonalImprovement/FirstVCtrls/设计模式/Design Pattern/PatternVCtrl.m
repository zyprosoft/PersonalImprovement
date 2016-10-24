//
//  PatternVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "PatternVCtrl.h"

#import "SimpleFactoryVCtrl.h"
#import "FactoryVCtrl.h"
#import "AbstractFactoryVCtrl.h"
#import "SingletonVCtrl.h"
#import "PrototypeVCtrl.h"
#import "BuilderPatternVCtrl.h"
#import "AdapterPatternVCtrl.h"
#import "BridgeVCtrl.h"
#import "CompositeVCtrl.h"
#import "DecoratorVCtrl.h"
#import "FacadeVCtrl.h"
#import "FlyweightVCtrl.h"
#import "ProxyVCtrl.h"
#import "ChainOfResponsibilityVCtrl.h"
#import "CommandVCtrl.h"
#import "InterpreterVCtrl.h"
#import "IteratorVCtrl.h"
#import "MeditorVCtrl.h"
#import "MementoVCtrl.h"
#import "ObserverVCtrl.h"
#import "StateVCtrl.h"
#import "StrategyVCtrl.h"
#import "TemplateVCtrl.h"
#import "VisitorVCtrl.h"

#import "CoordinatingController.h"

@interface PatternVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PatternVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"1简单工厂模式(Simple Factory)" class:@"SimpleFactoryVCtrl"];
    [self addCell:@"2工厂方法模式(Factory Method)" class:@"FactoryVCtrl"];
    [self addCell:@"3抽象工厂模式(Abstract Factory)" class:@"AbstractFactoryVCtrl"];
    [self addCell:@"4单例模式(Singleton)" class:@"SingletonVCtrl"];
    [self addCell:@"5原型模式(Prototype)" class:@"PrototypeVCtrl"];
    [self addCell:@"6建造者模式(Builder)" class:@"BuilderPatternVCtrl"];
    [self addCell:@"7适配器模式(Adapter)" class:@"AdapterPatternVCtrl"];
    [self addCell:@"8桥接模式(Bridge)" class:@"BridgeVCtrl"];
    [self addCell:@"9组合模式(Composite)" class:@"CompositeVCtrl"];
    [self addCell:@"10装饰模式(Decorator)" class:@"DecoratorVCtrl"];
    [self addCell:@"11外观模式(Facade)" class:@"FacadeVCtrl"];
    [self addCell:@"12享元模式(Flyweight)" class:@"FlyweightVCtrl"];
    [self addCell:@"13代理模式(Proxy)" class:@"ProxyVCtrl"];
    [self addCell:@"14职责链模式(Chain of Responsibility)" class:@"ChainOfResponsibilityVCtrl"];
    [self addCell:@"15命令模式(Command)" class:@"CommandVCtrl"];
    [self addCell:@"16解释器模式(Interpreter)" class:@"InterpreterVCtrl"];
    [self addCell:@"17迭代器模式(Iterator)" class:@"IteratorVCtrl"];
    [self addCell:@"18中介者模式(Mediator)" class:@"MeditorVCtrl"];
    [self addCell:@"19备忘录模式(Memento)" class:@"MementoVCtrl"];
    [self addCell:@"20观察者模式(Observer)" class:@"ObserverVCtrl"];
    [self addCell:@"21状态模式(State)" class:@"StateVCtrl"];
    [self addCell:@"22策略模式(Strategy)" class:@"StrategyVCtrl"];
    [self addCell:@"23模板方法模式(Template)" class:@"TemplateVCtrl"];
    [self addCell:@"24访问者模式(Visitor)" class:@"VisitorVCtrl"];
    
    [self addCell:@"Objective-C设计模式-TouchPainter" class:@"ddd"];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titleArray addObject:title];
    [self.classArray addObject:className];
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
    if ([cellTitle isEqualToString:@"Objective-C设计模式-TouchPainter"]){
        // Add the view controller's view to the window and display.
        CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
        ctrl = [coordinatingController activeViewController];
        [self.navigationController pushViewController:ctrl animated:YES];
    }else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
