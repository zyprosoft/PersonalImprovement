//
//  TestBlockVCtrl2.m
//  PersonalImprovement
//
//  Created by xiongyoudou on 16/3/15.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "TestBlockVCtrl2.h"
#import "TestBlockObj.h"

@interface TestBlockVCtrl2 ()

@end

@implementation TestBlockVCtrl2

- (void)viewDidLoad {
    [super viewDidLoad];

    // 定义block局部变量，并调用
    int (^block)(int para) = ^int (int para) {
        return para;
    };
    block(3);
    
    // 带有block参数的方法的调用
    [self methodWithBlock:^int(int para) {
        return para;
    }];
}


- (void)methodWithBlock:(int (^)(int para))block {
    if (block) {
        block (3);
    }
}

- (IBAction)clickBtn:(id)sender {
    if (self.block1) {
        self.block1();
    }
    if (self.block2) {
        self.block2([TestBlockObj new]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
