//
//  TestBlockVCtrl1.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/3/15.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "TestBlockVCtrl1.h"
#import "TestBlockVCtrl2.h"
#import "TestBlockObj.h"

@interface TestBlockVCtrl1 () {
    TestBlockObj *varObj;
    int varInt;
}

@end

@implementation TestBlockVCtrl1

NSObject *globalObj;
__weak NSObject *weakGlobalObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *obj = [NSObject new];
    NSLog(@"%@",obj);
    
    __weak NSObject *obj1 = [NSObject new];
    NSLog(@"%@",obj1);
    
    globalObj = obj1;
    NSLog(@"%@",globalObj);
    
    globalObj = [NSObject new];
    NSLog(@"%@",globalObj);
    
    weakGlobalObj = obj;
    NSLog(@"%@",weakGlobalObj);
    
    varObj = [TestBlockObj new];
    varObj.price = 4;
    varObj.obj = [NSObject new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@",varObj);
    
    NSLog(@"%d",varInt);
}

- (IBAction)clickBtn:(id)sender {
    
    NSLog(@"%@",globalObj);
    
    NSLog(@"%@",weakGlobalObj);
    
    TestBlockVCtrl2 *ctrl = [[TestBlockVCtrl2 alloc]initWithNibName:@"TestBlockVCtrl2" bundle:nil];
    ctrl.title = @"TestBlockVCtrl2";
//    __weak __typeof(self)weakself = self;
//    __weak NSObject *weakObj = varObj;
//    __block TestBlockObj *blockObj = varObj;
    
    //如此这般完全没有必要，int型成员变量可以自由修改值，也不会导致循环引用
//    __block int blockInt = varInt;
    ctrl.block1 = ^ {
        
//        NSLog(@"%@",varObj);
//
//        NSLog(@"%@",weakObj);
//
//        
        varObj = [TestBlockObj new];
//
        
//        weakObj = [TestBlockObj new];
//        blockObj = [NSObject new];
        
        
        NSLog(@"%d",varInt);
        
        varInt = 5;
        
//        NSLog(@"%d",blockInt);
//        blockInt = 5;
    };
    
    ctrl.block2 = ^(id obj) {
        varObj = obj;
    };
    
    // Blocks可以访问局部变量，但是不能修改
    __block int localVarInt = 4;
    void (^myBlcok)() = ^ {
        localVarInt = 6;
    };
    myBlcok();
    
    
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"TestBlockVCtrl1 dealloc");
}

@end
