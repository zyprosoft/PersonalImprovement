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

    [self testDeadLock1];
}

/**
 *  造成死锁的情况
 */
- (void)testDeadLock1 {
    // 任务1
    NSLog(@"1");
    
    //程序遇到了同步线程，那么它会进入等待，等待任务2执行完，然后执行任务3。但这是队列，会将新的任务所在的线程加到队列的最后，然后遵循FIFO原则执行任务。那么，现在任务2就会被加到最后，任务3排在了任务2前面。
    //任务3要等任务2执行完才能执行，任务2由排在任务3后面，意味着任务2要在任务3执行完才能执行，所以他们进入了互相等待的局面。【既然这样，那干脆就卡在这里吧】这就是死锁。
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
