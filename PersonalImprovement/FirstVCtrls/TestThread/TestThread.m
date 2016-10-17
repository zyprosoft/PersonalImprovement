//
//  TestThread.m
//  PersonalDevelopment
//
//  Created by xiong有都 on 16/2/3.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "TestThread.h"

@interface TestThread ()

@end

/**
 *  参照网址http://www.superqq.com/blog/2015/10/16/five-case-know-gcd/解析，evernote有备份
 */

@implementation TestThread

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testTaskOnQueue];
}

// 测试分别在串行队列/并行队列上执行sync/async的操作
- (void)testTaskOnQueue {
    
    NSLog(@"当前线程 %@", [NSThread currentThread]);
    
    dispatch_queue_t serialQ = dispatch_queue_create("serialQueue", NULL);
    dispatch_sync(serialQ, ^{
        NSLog(@"串行队列同步派发 %@", [NSThread currentThread]);
        // 打印出来还是主线程
    });
    dispatch_async(serialQ, ^{
        NSLog(@"串行队列异步派发 %@", [NSThread currentThread]);
        // 新开辟了线程
    });

    
    dispatch_queue_t concurrentQ = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQ, ^{
        NSLog(@"并行队列同步派发 %@", [NSThread currentThread]);
        // 打印出来还是主线程
    });
    dispatch_async(concurrentQ, ^{
        NSLog(@"并行队列异步派发 %@", [NSThread currentThread]);
        // 新开辟了线程
    });
}

/**
 *  造成死锁的情况
 */
- (void)testDeadLock1 {
    // 任务1
    NSLog(@"1");
    
    /* 【死锁的个人理解】
    ○ 首先主线程对应的有一个主队列，该队列先进先出，顺序执行
    ○ 执行到dispatch_sync函数时，会将该函数的执行加入到队列的最后面，等待执行
    ○ 在执行dispatch_sync函数时，会将block中的操作加入到主队列的末尾
    ○ dispatch_sync函数尽管被执行，但是不会立即返回，因为需要等待block执行完了才能返回
    因此最后block根本执行不了，因为block的执行需要dispatch_sync函数执行完的返回（同在一个队列，并且顺序执行），而dispatch_sync函数的返回需要block执行完（dispatch_sync的作用）。从而导致死锁
     */
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        // 任务2
        NSLog(@"2");
    });
    
    // 任务3
    NSLog(@"3");
}

- (void)testDeadLock2 {
    NSLog(@"1"); // 任务1
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ NSLog(@"2"); // 任务2
    });
    NSLog(@"3"); // 任务3
}

- (void)testDeadLock3 {
    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 任务1
    dispatch_async(queue, ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(queue, ^{ NSLog(@"3");
            // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
}

- (void)testDeadLock4 {
    NSLog(@"1"); // 任务1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
}

- (void)testDeadLock5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1"); // 任务1
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2"); // 任务2
        });
        NSLog(@"3"); // 任务3
    }); NSLog(@"4"); // 任务4
    while (1) { }
    NSLog(@"5"); // 任务5
}

- (void)loadView {
    self.view = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
