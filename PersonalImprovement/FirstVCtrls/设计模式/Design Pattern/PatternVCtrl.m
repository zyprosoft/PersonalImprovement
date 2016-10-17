//
//  PatternVCtrl.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/8/17.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "PatternVCtrl.h"

#pragma mark - design pattern系列1
#import "AbstractFactoryVCtrl1.h"
#import "AdapterPatternVCtrl1.h"
#import "BridgePatternVCtrl1.h"
#import "BuilderPatternVCtrl1.h"
#import "ChainOfResponsibilityVCtrl1.h"
#import "CommandVCtrl1.h"
#import "CompositeVCtrl1.h"
#import "DecoratorVCtrl1.h"
#import "FacadeVCtrl1.h"
#import "FlyweightVCtrl1.h"
#import "IteratorVCtrl1.h"
#import "MediatorVCtrl1.h"
#import "MementoVCtrl1.h"
#import "ObserverVCtrl1.h"
#import "PrototypeVCtrl1.h"
#import "ProxyVCtrl1.h"
#import "SingletonVCtrl1.h"
#import "StateVCtrl1.h"
#import "StrategyVCtrl1.h"
#import "TemplateVCtrl1.h"
#import "VisitorVCtrl1.h"

#pragma mark - design pattern系列2
#import "SimpleFactoryVCtrl2.h"
#import "StrategyVCtrl2.h"
#import "DecoratorVCtrl2.h"
#import "ProxyVCtrl2.h"
#import "FactoryVCtrl2.h"
#import "TemplateVCtrl2.h"
#import "FacadeVCtrl2.h"
#import "BuilderVCtrl2.h"
#import "ObserverVCtrl2.h"
#import "StateVCtrl2.h"
#import "AdaptorVCtrl2.h"
#import "MementorVCtrl2.h"
#import "CompositeVCtrl2.h"
#import "IteratorVCtrol2.h"
#import "BridgeVCtrl2.h"
#import "CommandVCtrl2.h"
#import "ChainOfResponsibilityVCtrl2.h"
#import "MeditorVCtrl2.h"
#import "FlyweightVCtrl2.h"
#import "InterpreterVCtrl2.h"
#import "VisitorVCtlr2.h"

@interface PatternVCtrl ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PatternVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"AbstractFactory" class:@"AbstractFactoryVCtrl1"];
    [self addCell:@"Adapter" class:@"AdapterPatternVCtrl1"];
    [self addCell:@"Bridge" class:@"BridgePatternVCtrl1"];
    [self addCell:@"Builder" class:@"BuilderPatternVCtrl1"];
    [self addCell:@"ChainOfResponsibility" class:@"ChainOfResponsibilityVCtrl1"];
    [self addCell:@"Command" class:@"CommandVCtrl1"];
    [self addCell:@"Composite" class:@"CompositeVCtrl1"];
    [self addCell:@"Decorator" class:@"DecoratorVCtrl1"];
    [self addCell:@"Facade" class:@"FacadeVCtrl1"];
    [self addCell:@"Flyweight" class:@"FlyweightVCtrl1"];
    [self addCell:@"Iterator" class:@"IteratorVCtrl1"];
    [self addCell:@"Mediator" class:@"MediatorVCtrl1"];
    [self addCell:@"Memento" class:@"MementoVCtrl1"];
    [self addCell:@"Observer" class:@"ObserverVCtrl1"];
    [self addCell:@"Prototype" class:@"PrototypeVCtrl1"];
    [self addCell:@"Proxy" class:@"ProxyVCtrl1"];
    [self addCell:@"Singleton" class:@"SingletonVCtrl1"];
    [self addCell:@"State" class:@"StateVCtrl1"];
    [self addCell:@"Strategy" class:@"StrategyVCtrl1"];
    [self addCell:@"Template" class:@"TemplateVCtrl1"];
    [self addCell:@"Visitor" class:@"VisitorVCtrl1"];
    
    
    [self addCell:@"简单工厂" class:@"SimpleFactoryVCtrl2"];
    [self addCell:@"策略模式" class:@"StrategyVCtrl2"];
    [self addCell:@"装饰模式" class:@"DecoratorVCtrl2"];
    [self addCell:@"代理模式" class:@"ProxyVCtrl2"];
    [self addCell:@"工厂方法模式" class:@"FactoryVCtrl2"];
    [self addCell:@"模板方法模式" class:@"TemplateVCtrl2"];
    [self addCell:@"外观模式" class:@"FacadeVCtrl2"];
    [self addCell:@"建造者模式" class:@"BuilderVCtrl2"];
    [self addCell:@"观察者模式" class:@"ObserverVCtrl2"];
    [self addCell:@"抽象工厂模式" class:@"AbstractFactoryVCtrl2"];
    [self addCell:@"状态模式" class:@"StateVCtrl2"];
    [self addCell:@"适配器模式" class:@"AdaptorVCtrl2"];
    [self addCell:@"备忘录模式" class:@"MementorVCtrl2"];
    [self addCell:@"组合模式" class:@"CompositeVCtrl2"];
    [self addCell:@"迭代器模式" class:@"IteratorVCtrol2"];
    [self addCell:@"单例模式" class:@"SingletonVCtrl2"];
    [self addCell:@"桥接模式" class:@"BridgeVCtrl2"];
    [self addCell:@"命令模式" class:@"CommandVCtrl2"];
    [self addCell:@"职责链模式" class:@"ChainOfResponsibilityVCtrl2"];
    [self addCell:@"中介者模式" class:@"MeditorVCtrl2"];
    [self addCell:@"享元模式" class:@"FlyweightVCtrl2"];
    [self addCell:@"解释器模式" class:@"InterpreterVCtrl2"];
    [self addCell:@"访问者模式" class:@"VisitorVCtlr2"];
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
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
