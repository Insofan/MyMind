//
//  Item43ViewController.m
//  EffectiveObjective-C
//
//  Created by Insomnia on 2018/8/28.
//  Copyright © 2018年 Insomnia. All rights reserved.
//

#import "Item43ViewController.h"
#import "Item43CustomOperation.h"

@interface Item43ViewController ()
@property (nonatomic, assign) int ticketSurplusCount;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation Item43ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];

    /**
     * 当前线程使用子类, NSInvocationOperation
     */
//    [self inovocationOperation];

    /**
     * 在其他线程使用 NSInvocationOperation
     */
//    [self inovocationOperationOther];

    /**
     * 当前线程使用NSBlockOperation
     */
//    [self blockOperation];
    /**
     * 使用NSBlockOperation的executionblock 方法
     */
//    [self blockOperationAddExecutionBlock];

    /**
     * [使用集成自 NSOperation的子类
     */
//    [self customOperation];

    //    使用addOperation: 添加操作到队列中
//        [self addOperationToQueue];

    //    使用 addOperationWithBlock: 添加操作到队列中
//        [self addOperationWithBlockToQueue];

    //    设置优先级
//    [self setQueuePriority];

    //    设置最大并发操作数（MaxConcurrentOperationCount）
//    [self setMaxConcurrentOperationCount];

    //    添加依赖
//    [self addDependency];

    //    线程间的通信
//    [self communication];

//    完成操作
//    [self completionBlock];

//    不考虑线程安全
    [self initTicketStatusNotSafe];

//    考虑线程安全
//    [self initTicketStatusSave];
}



#pragma mark 当前线程使用子类, NSInvocationOperation

- (void)inovocationOperation {
    NSLog(@"%s", __func__);
    //1. 创建 NSInvocationOperation
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    //2. 调用 start方法开始执行操作
    [operation start];
}

#pragma mark 在其他线程使用 NSInvocationOperation

- (void)inovocationOperationOther {
    NSLog(@"%s", __func__);
    //这个方法可以直接生成一个线程并启动它，而且无需为线程的清理负责
    [NSThread detachNewThreadSelector:@selector(inovocationOperation) toTarget:self withObject:nil];
}

#pragma mark 当前线程使用NSBlockOperation

- (void)blockOperation {
    NSLog(@"%s", __func__);
// 1.创建 NSBlockOperation 对象
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }];
    // 2.调用 start 方法开始执行操作
    [operation start];
}

#pragma mark 使用NSBlockOperation的executionblock 方法

- (void)blockOperationAddExecutionBlock {
    NSLog(@"%s", __func__);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1----%@", [NSThread currentThread]);
        }
    }];

    [operation addExecutionBlock:^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2----%@", [NSThread currentThread]);
        }
    }];

    [operation addExecutionBlock:^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3----%@", [NSThread currentThread]);
        }
    }];

    [operation addExecutionBlock:^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4----%@", [NSThread currentThread]);
        }
    }];

    [operation start];

}

#pragma mark 使用继承自NSOperation的子类

- (void)customOperation {
    Item43CustomOperation *op = [Item43CustomOperation new];
    [op start];
}

#pragma mark 添加操作到队列中

- (void)addOperationToQueue {
    //队列并不会挨个执行
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    // 使用 NSInvocationOperation 创建操作1
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];

    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];

    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
    //op3 会报warn Class _NSZombie___NSOperationInternal is implemented in both ?? (0x14c4702d0) and ?? (0x151c7ee50). One of the two will be used. Which one is undefined.

}


#pragma mark 使用 addOperationWithBlock: 将操作加入到操作队列中

- (void)addOperationWithBlockToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.使用 addOperationWithBlock: 添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

#pragma mark 设置优先级

- (void)setQueuePriority {
    //可以一定程度上控制线程的顺序
    // 就绪状态下，优先级高的会优先执行，但是执行时间长短并不是一定的，所以优先级高的并不是一定会先执行完毕
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{

        for (int i = 0; i < 2; i++) {
            NSLog(@"1-----%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    }];
    [op1 setQueuePriority:(NSOperationQueuePriorityVeryLow)];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{

        for (int i = 0; i < 2; i++) {
            NSLog(@"2-----%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    }];

    [op2 setQueuePriority:(NSOperationQueuePriorityVeryHigh)];

    [queue addOperation:op1];
    [queue addOperation:op2];
}

#pragma mark 也可以一定程度上 确定执行顺序

- (void)setMaxConcurrentOperationCount {
    //也可以一定程度上 确定执行顺序
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.设置最大并发操作数
    queue.maxConcurrentOperationCount = 1; // 串行队列
//    queue.maxConcurrentOperationCount = 2; // 并发队列
//    queue.maxConcurrentOperationCount = 8; // 并发队列

    // 3.添加操作
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

#pragma mark 添加依赖

- (void)addDependency {
    //1. 创建队列
    NSOperationQueue *queue = [NSOperationQueue new];

    //2. 创建操作

    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.添加依赖
    [op2 addDependency:op1];    // 让op2 依赖于 op1，则先执行op1，在执行op2

    // 4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];

}

#pragma mark 完成操作 completionBlock
- (void)completionBlock {
    //不同线程 , 但有依赖关系
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.添加完成操作
    op1.completionBlock = ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    };

    // 4.添加操作到队列中
    [queue addOperation:op1];
}

#pragma mark  线程间通信

- (void)communication {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];

    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 异步进行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }

        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 进行一些 UI 刷新等操作
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2];      // 模拟耗时操作
                NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
    }];
}

#pragma mark - 线程安全
#pragma mark 非线程安全 不使用 NSLock 初始化火车票数量 卖票窗口(非线程安全)并开始卖票

/**
 * 售卖火车票(非线程安全)
 */



- (void)initTicketStatusNotSafe {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程

    self.ticketSurplusCount = 50;

    // 1.创建 queue1,queue1 代表北京火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;

    // 2.创建 queue2,queue2 代表上海火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;


    // 3.创建卖票操作 op1
    @weakify(self);
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        @strongify(self);
        [self saleTicketNotSafe];
    }];

    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        @strongify(self);
        [self saleTicketNotSafe];
    }];

    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 * 线程安全：使用 NSLock 加锁
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程

    self.ticketSurplusCount = 50;

    self.lock = [[NSLock alloc] init];
    // 1.创建 queue1,queue1 代表北京火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;

    // 2.创建 queue2,queue2 代表上海火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;

    // 3.创建卖票操作 op1

    @weakify(self);
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        @strongify(self);
        [self saleTicketSafe];
    }];

    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        @strongify(self);
        [self saleTicketSafe];
    }];

    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

#pragma mark Task

- (void)task1 {
    for (int i = 0; i < 2; ++i) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@", [NSThread currentThread]);
    }
}

/**
 * 任务2
 */
- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);     // 打印当前线程
    }
}


/**
 * 售卖火车票(非线程安全)
 */
- (void)saleTicketNotSafe {
    while (1) {

        if (self.ticketSurplusCount > 0) {

            //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%d 窗口:%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        [self.lock lock];

        if (self.ticketSurplusCount > 0) {
            //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%d 窗口:%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }
        // 解锁
        [self.lock unlock];

        if (self.ticketSurplusCount <= 0) {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}


@end
