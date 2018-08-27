# iOS面试之道

## Q: 什么是arc

A： ARC即Automatic Reference Counting 自动引用计数， 取代原先的Manual Reference Counting， 自动生成retain/release. 

## Q: 什么情况下会出现循环引用

A：循环引用是指两个或两个以上的对象互相强引用， 导致所有对象无法被释放的现象， 是内存泄露（memory leak）的一种现象。 父对象对子对象强引用， 子对象对父对象强引用， 要释放父要先释放子， 要释放子要先释放父， 有点像死/活锁。解决方法将子对象属性由strong改为weak， 指向单不拥有对象，内存泄漏可以用Xcode中的Debug Memory Graph 检查， Xcode会在runtime中自动汇报内存泄露情况。

## Q：说明并比较关键词：strong， weak， assign和copy

- strong 表示指向并拥有该对象， 修饰对象引用计数会加1。 该对象只要计数不为0， 就不会被销毁，但可以强行将其设为nil销毁它。

- weak表示指向但不拥有该对象， 修饰对象计数不会加1， 无须手动设置该对象会在内存中自动销毁

- assign用于修饰基本数据类型， 如NSInteger， CGFloat等， 这些数值存在于栈中

  ##### weak与assign比较

- weak一般用来修饰对象， assign一般用来修饰基本数据类型， 因为assign修饰的对象被释放后， 对象的地址在堆依然存在， 会造成野指针， 造成崩溃， 而栈中的内存系统会自动处理， 不会造成野指针

- copy与strong类似。不同之处是， strong的复制是多个对象指针指向同一地址， 而copy是复制一份新对象， 指针在不同的地址。 copy一般用在修饰有对应可变类型的不可变对象上， 如NSString, NSArray和NSDictionary

## Q: 说明并比较关键词： aotomic和nonatomi

- aotmic修饰的对象会保证setter和getter的完整性，任何线程访问它都可以得到一个完整的初始化后的对象， 因为要保证线程安全，所以速度比较慢， automic比nonatomic安全， 但也不是绝对的线程安全。 例： 多个线程同时调用set和get时， 就会导致获得的对象值不一样， 要想绝对的线程安全， 要用@synchronize。
- nonatomic修饰的对象不保证setter和getter的完整性， 所以， 当多个线程访问它时， 它可能返回未初始化的对象， 正因为如此， nonatomic比atomic速度快， 但是线程不安全。

## Q: 说明并比较关键词：__weak 和_ _block

- __weak与weak基本相同， 前者是用来修饰变量， 后者使用来修饰属性 property， _ _weak主要用来防止block中的循环引用
- _ _block用于修饰变量，它是引用修饰， 所以， 其修饰的值是动态变化的， 即可以被重新赋值， _ _block主要用于修饰block内部将要修改的外部变量

## Q: 什么是block？它和代理的区别是什么

block结构上类似函数指针，只是多做了一个查表动作。block和代理都是回调的方式， block是一段封装好的代码， 代理的声明和实现一般分开， 比如UITableDelegate， 就是代理的声明在UITableView中， 实现在某个UIViewController中。

block和代理的区别首先在于， block集中代码块， 而代理分散代码块， 所以block更适合轻便， 简单的回调， 如网络传输。 而代理适用于公共借口较多的情况， 这样也容易解耦代码。

两者的另一个区别在于， block运行成本高， block出栈时， 需要将使用的数据从栈内存复制到堆内存， 当然， 如果是对象是就是加计数， 使用完或者block置为nil后才消除， delegate只是保存了一个对象指针， 直接回调， 并没有额外消耗

相对c的函数指针， 只是对了一个查表动作

## Q:属性声明代码风格考查

A：请问下面代码有什么问题

```objective-c
@property (nonatomic, strong) NSString *title;
@property (assign, nonatomic) int worID;
```

- title不应该用strong修饰， 而应该用copy， 因为NSString是不可变的数据类型， 它有对应的NSMutableString数据类型， 用strong来修饰会有NSString被修改的可能， 例：

```objective-c
self.title = @"title";
NSMutableString *mutableTitle = @"mutableTitle";
self.title = mutableTitle;
```

有对应的可变数据类型的不可变数据类型都应该用copy修饰， copy表示该属性不能被修改， 如果可变数据类型如NSMutableString用copy修饰， 那么当对其修改时， 程序就会崩溃

- workID不应该用int， 而类型应该用NSInteger类型， int只表示32位整型数据， 而NSInteger在32位计算机中与int 一样， 在64位计算机中则是64位整型数据。 对于不同类型的计算机， NSInteger更加灵活和准确， 同理可以用NSUInteger代替unsigned， 用CGFloat替代float
- 在属性声明最好遵循一定顺序， 这样可读性更高

```objective-c
@property (nonatomic, copy) NSString *title;
@property (nonatomic，assign) NSInteger worID;
```

## Q:架构解耦代码考查

请问下面代码有什么问题

```objective-c
typedef enum{
    Normal,
    VIP;
} CustomerTyep;

@interface Customer: NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, assign) CustomerType customerType;
@end
```

- enum定义的写法不够好。 应使用NS_ENUM来定义枚举。同时， 在枚举的每个类型前应加上enum的名字， 这样方便在swfit中直接调用。
- UIImage不应该出现在Customer中， Customer明显是一个Model类， UIImage应该属于View部分， 无论是MVC还是MVVM亦或是VIPER， model都应该与View划分开。

```objc
type NS_ENUM(NSInteger, CustomerType) {
    CustomerTypeNormal,
    CustomerTypeVIP;
};

@interface Customer: NSObject
    
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSData *profileImageData;
@property (nonatomic, assign) CustomerType customerType;

@end
```

## Q:内存管理语法考查

请问下面的代码打印结果是什么

```objective-c
NSString *firstStr = @"helloword";
NSString *secondStr = @"helloword";

if (firstStr == secondStr) {
    NSLog(@"Equal");
} else {
    NSLog(@"Not Equal");
}
```

- 输出Equal
- ==这个符号并不是判断两个值是否相等， 而是判断两个指针是否指向同一地址， 如果要判断NSString的值是否相等应该用isEqual这个方法
- 上面代码中， 两个指针指向不同的对象， 尽管它们的值相同。 但是iOS的编译器优化了内存分配， 当两个指针指向同一个值的NSString时， 两个指针指向同一地址， 所以会打印“Equal”。

## Q:多线程语法考查

请问下面代码有什么问题

```objective-c
- (void)viewDidLoad {
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    alertLabel.text = @"Wait 4 seconds...";
    self.view addSubview:alertLabel];
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
     	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:4]];
        alertLabel.text = @"Ready to go!";
    }];
}
```

上面代码中alertLabel并不会刷新位Ready to go， 原因是所有与UI相关的操作应该在主线程进行。 我们当然可以在一个后台线程中等待4， 但是一定要在主线程中更新UI

```objective-c
- (void)viewDidLoad {
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    alertLabel.text = @"Wait 4 seconds...";
    self.view addSubview:alertLabel];
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
     	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:4]];
     	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
        	alertLabel.text = @"Ready to go!";
     	}];
    }];
}
```

## Q:以scheduledTimerWithTimeInterval的方式出发的timer， 在滑动页面上的列表时， timer会暂停， 为什么？该如何解决

造成此问题是因为滑动列表时， 当前线程的runloop切换了mode的模式， 导致timer暂停

runloop中的mode主要用来指定时间在runloop中的优先级， 具体有以下几种

- Default（NSDefaultRunLoopMode)： 默认设置， 一般情况使用。
- Connection（NSConnectionReplyMode): 用于处理NSConnection相关时间， 开发者一般用不到
- Modal（NSModalPanelRunLoopMode）： 用于处理modal panels事件
- Event Tracking（NSEventTrackingRunLoopMode): 用于处理拖拽和用户交互的模式
- Common（NSRunloopCommonMode）： 模式合集， 默认包括Default， Modal和Event Tracking三大模式， 可以处理几乎所有事件

再看上述问题， 在列表滑动时， runloop mode由原先的Default切换到了Event Tracking模式， timer原来运行在Default模式， 被关闭后自然停止工作了。

解决方法

方案一：

是将timer加入到NSRunloopCommonModes中

```objective-c
[[NSRunLoop currentRunLoop] addTimer:timer forMode: NSRunLoopCommonMode];
```

方法二：

是将timer放到另一个线程中

```objective-c
dispatch_async(dispatch_get_global_queue(0, 0), ^{
   timer = [NSTimer scheduledTimerWithTimerInterval:1 target:self selector:@selector(repeat:) userInfo:nil repeates:true];
   [[NSRunLoop currentRunLoop] run];
});
```

## Q:Swift为什么将String， Array和Dictionary设置位值类型

OC中String， Array和Dictionary的类型位引用类型。

- 值类型相比引用类型， 最大优势可以高效的使用内存。 值的类型在栈上， 引用的类型在堆上， 栈上的操作仅是单个指针上下移动， 堆上操作则牵扯合并、移位、重新链接等。也就是说， swift这样设计大幅减少了堆上的内存分配和回收次数。同时， copy-on-write又将值传递和复制的开销降到最低。
- Swift将String， Array和Dictionary设计成值类型也是为了线程安全， 通过swift的let设置， 是的这些数据达到真正意义上的不变， 根本解决了多线程中内存访问操作顺序问题
- Swift将String， Array和Dictionary设计成值类型还可以提升api的灵活度， 例如通过实现Collection这样的协议， 可以遍历String， 使得开发更加灵活， 高效。

## Q:Message send 如果找不到对象， 则会如何进行后续处理

Message send找不到对象会分为两种情况：对象为空（nil）， 对象不为空， 却找不到对应的方法

- 对象为空时， OC在向nil发送消息是有效的， 在runtime中不会产生任何效果。 如果消息中返回的值是对象， 那么给nil发送消息返回nil， 如果方法返回值是结构体， 那么给nil发送消息返回是0。
- 对象不为空， 却找不到对应的方法时， 程序有异常， 引发unrecognized selector

## Q:什么是method swizzling

每个类都维护一个方法列表， 其中方法名与其实现是一一对应的关系， 即SEL（方法名）和IMP（指向实现的指针）的对应关系。 method swizzling 可以在runtime中将SEL和IMP的对应关系进行更换， 比如原来SELa指向IMPa， 更换好SELa可以指向IMPb。

```objective-c
oneSEL = @selector(methodOne:);
Method oneMethod = class_getInstanceMethod(selfClass, oneSEL);

twoSEL = @selector(methodTwo:);
Method twoMethod = class_getInstanceMethod(selfClass, twoSEL);

BOOL addSucc = class_addMethod(selfClass, oneSEL, method_getImplementation(twoMethod), method_getTypeEncoding(oneMethod));

if (addSucc) {
    class_replaceMethod(selfClass, twoSEL, method_getImplementation(oneMethod), method_getTypeEncoding(oneMethod));
} else {
    method_exchangeImplementations(oneMethod, twoMethod);
}
```

## Q:isKindOfClass和isMemberOfClass有什么不同

```
[obj isKindOfClass:[SomeClass class]];
[obj isMemberOfClass:[SomeClass class]];
```

- 在上面的代码中， 第一行代码的isKindOfClass用来判断obj是否为SomeClass或其子类
- isMemberOfClass，用来判断obj当且仅当obj是SomeClass（非子类）

## Q:能否通过Category给已有的类添加属性

可以， 但要使用runtime， 用objc_getAssociateObject和objc_setAssociateObject来实现， 具体代码见Effective OC

## Q:LLDB中p和po有什么区别

- p是expr -的缩写， 他的工作是把接收到的参数在当前环境下进行编译， 然后打印出对应的值
- po是expr -o-， 他所做的工作和p类似，如果接收到的是一个指针， 那么他会调用对象的description/debugDescription放发并进行打印。 如果接受的是core foundation对象那么会有CFShow方法进行打印，如果两个方法都失败，则和p打印出结果一样
- 总的来说po会比p打印出更多内容，一般p即可， 因为p操作较少， 效率较高。

## Q:Xcode中的Buildtime issues和Runtime issues有什么区别

- Buildtime issues有三类：编译器识别出的警告(Warning),错误(Error)和静态分析(Static Code Analysis)。
- 其中静态分析有三类：未初始化变量， 未使用数据， 和API使用错误
- Runtime issues有三类：线程问题、UI布局和渲染问题，以及内存问题， 线程问题最多列如数据竞争

## Q:App启动时间过长， 该怎样优化

App启动时间过长， 可能由多个原因造成。 从理论上说， App的启动时间是由main（）函数之前t1和main函数之后t1的加载时间造成的。

关于t1， 需要分析App的启动日志， 具体方法实在Xcode中添加DYLD_PRINT_STATISTICS环境变量， 将其值设置为1， 这样就可以的到启动日志

```
Some log
```

通过日志可以知道， aap主要在动态加载库， 重定位， 初始化三个方面小号时间过长， 优化手段就有了

- 减少东岱库的数量， 苹果推荐动态库不要多于6个
- 减少OC的数量， 列如合并删除， 可以加快动态链接重定位的速度
- 使用initialize方法替换load方法或是尽量将load方法中的代码延迟调用， 减小初始化的时间

关于t2， 主要是构建第一个页面并渲染完成的时间， 要在加载页具体观察， 如viewDidLoad方法和viewWillAppear方法。

## Q:如何用Xcode检测代码中的循环引用

一种方法是使用Xcode中的Memory Debug Graph，另一种是[MLeaksFinder](https://github.com/Tencent/MLeaksFinder)

## Q:怎样解决EXC_BAD_ACCESS

产生EXC_BAD_ACCESS，是因为僵尸指针， 有以下集中方法：

- 设置全局断点， 快速定位bug所在：这种方法效果一般
- 重写Object的respondsToSelector方法：这种方法效果一般， 并且需要在每个class上进行定点排查， 所以不推荐使用此方法
- 使用Zombie和Address Sanitizer：可以在绝大多数数情况下定位问题代码

## Q:要在UIView上定义一个Label有几种方式

SB、xib或者纯代码， 然后用Frame或是auto layout

## Q:storyboard/xib和纯代码构建UI相比， 有哪些优点和缺点

优点：

- 可视化，简单、拖拉拽
- 跳转关系清楚。在storyboard里可以清楚的区分view controller之间的跳转关系

缺点：

- 写作冲突: 多人编辑时， 很容易产生难以解决的冲突， 因为 sb/xib自带xcode和系统的版本号， 
- 很难做到界面继承和重用:代码很容易做到
- 不利于进行模块化管理:在storyboard/xib中搜索起来很不方便， 并且不可能同意修改多个UI的属性值， 必须一个个地改， 代码中使用一个工厂模式就可以解决
- 影响性能:列如构建首页UI时， 代码书写和优化会比storyboard多图层的渲染要好很多

## Q:Auto Layout 和 Frame在UI布局和渲染上有什么区别

- Auto Layout 是针对多尺寸屏幕的设计。其本质是通过线性不等式设置UI空间的相对位置， 从而适配多种屏幕尺寸
- Frame是基于XY坐标轴系统的布局机制。他限定了UI空间的具体位置， 是从iOS开发中最底层， 最基本的界面布局机制
- Auto Layout 的性能比Frame差很多。Auto Layout是通过求解线性不等式转化位Frame进行布局， 其中计算量非常大， 通常Auto Layout的性能消耗是Frame的十倍

性能消耗解决办法：

- 尽量压缩视图层级， 减少计算量
- 也可以将计算放在后台线程来处理， 这样就可以不阻塞主线程操作， 其结果可以被缓存

## Q:UIView和CALayer有什么区别

- UIView和CALayer都是UI的操作对象：两者都是NSObject的子类， 发生在UIView上的操作， 也会发生在响应的CALayer上
- UIVew是CALayer用于交互的对象。UIView是UIResponder的子类， 并且提供了CALayer很多没有的交互借口， 主要负责用户触发的各种操作
- CALayer在图像和动画的渲染上性能更好， 这是因为UIView有冗余的交互借口， 而且相比CALayer还有层级之分， CALayer无须处理交互时进行渲染， 可以节省大力时间

## Q:说明并比较关键词:frame， bounds和center

- frame是指当前视图相对于父视图的平面坐标系统中的位置，大小
- bounds是指当前视图相对于自己平面坐标的位置和大小
- center是一个CGPoint，指当前视图在父视图平面坐标系统中中间的点

## Q:说明并比较方法：layoutIfNeeded， layoutSubviews和setNeedsLayout

- layoutIfNeeded方法一旦调用， 主线程会立即强制重新布局， 它从当前视图开始， 一直到玩称所有姿势图

- layoutSubviews用来定义视图尺寸。 它是系统调用的， 开发这不能手动调用。 我们所能做的就是重写该方法， 让系统在调整尺寸是能够按照我们希望的效果进行布局， 这个方法主要在屏幕旋转， 滑动或者触摸界面修改子视图时被触发

- setNeedsLayout与layoutIfNeeded相似， 唯一不同的就是它不会立刻强制视图重新布局， 而是在下一个布局周期才会触发， 它主要用于多个视图布局先后更新的场景， 如两个位置不断变化的的点连成一条直线

## Q:说明并比较关键词：Safe Area， SafeAreaLayoutGuide和SafeAreaInsets

由于iPhone X采用了全新的刘海设计， 所以， iOS11中引入了 Safe Area的概念

- Safe Area是值app合理显示的区域， 它不包括 status bar， navigation bar， tab bar和toolbar等， 在iPhone X中一般是指扣除了 status bar （44）和底部的home indicator（34）， 这样app中的内容不会被“刘海”或者影响底部的手势操作
- SafeAreaLayoutGuide是指Safe Area的区域和限制， 在布局中， 可以分别取得它的上，下， 左，右
- SafeAreaInsets限定了Safe Area区域与整个屏幕之间的布局关系。 一般用上下左右4个值来获取Safe Area与屏幕边缘之间的距离

## Q:在iOS中实现动画的方式有几种

主要有三种UIView Animation， CALayer Animation和 UIViewPropertyAnimator

- UIView Animation可以实现基于UIView的简单动画， 它是CALayer Animation的封装， 主要可以实现移动、旋转、变色等基本操作。其基本函数为+ animateWithDuration:animations: , duration为基本参数, 在block中对UIView属性的调整就是动画结束后的最终效果. 除此之外, 他还有关键帧动画和两个view转换接口, 它的动画无法回撤, 暂停, 与手势交互
- CALayer Animation是在更底层CALayer上的动画接口.除了可以实现UIView Animation的功能, 他可以修改更多实现更复杂的动画. 其实现的动画可以回撤, 暂停与手势交互
- UIViewPropertyAnimator是iOS10中引进的处理动画的接口, 他也是基于UIView实现的, 他可以实现所有的UIView Animation效果, 他最大的优点在于timing function以及与手势配合的交互变成, 其动画设置相比CALayer Animation十分简便

## Q:控制屏幕上的圆形小球, 使其水平向右滑动200个point

主要要问清需求

## Q:在iOS开发中, 如何保证App的UI在iPhone, iPad和iPad分屏下依然适用

苹果在iOS 8中引入了Adaptive UI的概念, 要保证App的UI在各种情况下适用需要注意一下几点

- 采用Auto Layout 与用frame设置的绝对位置不同, 所有UI空间将保持相对位置, 例如, 将label设置成对应屏幕的 center X和 center Y, 此时无论是在iPhone 中还是在iPad中, 此label豆浆相对于屏幕居中
- 采用Size Class, 很多实用, UI控件在iPhone中尺寸刚好, 但在iPad上有可能偏小. 此时用Size Class可以分别在不同的机型上安装对应的constraint, 针对不同情况Regular和Compact设置横屏和竖屏
- 多屏主要分三种: Slide Over, Split View 和Picture in Picture, 苹果明确支出App应该支持Split Over和Split View, 应和UI设计沟通, 配合Size Class 进行适配

## Q:如何用Drag & drop实现图片拖动功能

iOS 11 加入功能, 代码实现

## Q:说明并比较关键词:contentView, contentInset, contentSize和contentOffset

- UIScrollView上显示内容的区域被称为 contentView, 一般情况下, 用户对UIScrollView的操作, 例如, addSubview这样操作都是在contentView中进行的
- contentInset是指contentView与UIScrollView的便捷. 类似网页开发中的padding
- contentSize是指contentView的大小, 它一般超过屏幕大小, 是整个UIScrollView实际内容的大小, 例如一个4倍屏幕的尺寸, 用户在缩放的时候只能看到其中1/4的内容, 那他的size是4个屏幕合起来的
- contentOffset是当前contentView相对于左上角原点的坐标

## Q:说明UITableViewCell的重用机制

UITableView的每一行就是UITableViewCell. 绝大多数UITableViewCell的构图都一样, 只是内容不同而已.所以, 可以将同一类型的UITableViewCell标记为相同的Identifier, 然后用reuseIdentifier进行构建, 配合不同内容进行批量使用.

当用户滑动列表时, 如果reuseIdentifer部位nil, 则UITableView会自动调用已经生成好的UiTableView来展示内容, 否则每次滑动都会创建新的UITableViewCell, 这样浪费资源, 造成主线程卡顿.

## Q:说明并比较协议:UITableViewDataSource和UITableViewDelegate

一般在UIViewController上配置UITableView时, 都会用到这两个协议, 这两个协议由当前UIViewController实现.

- UITableViewDataSource控制UITablView的实际数据:例如, 有多少section, 每个section有多少行, 每行用那种UITableViewCell. 其中, numOfRows和cellForRowAtIndexPath这两个方法必须被实现, numOfSectionsn默认为1
- UITableViewDelegate用来处理UITableView和Ui的交互, 例如, 设置UITableView的header和footer, 点击, 拖动, 删除某个UITableViewCell对应的操作. 它所有的方法都是可选方法, 有默认实现.

## Q:说明并比较协议:UICollectionViewDataSource,UICollectionViewDelegate和UICollectionViewDelegateFlowLayout

- UICollectionViewDataSource用来管控UICollectionView的实际数据. 例如:有多少section, 每个section有多少个item, 每个item对应的UI如何. 其中, numOfItems和cellforItemAtIndexPath等
- UICollectionViewDelegate用来处理交互. 例如, 点击, 拖动, 高亮某个item, 它是所有的方法都是可选方法, 有默认实现
- UICollectionViewDelegateFlowLayout用来处理UICollectionView的布局及其行为, 列如item的尺寸, collectionView的滚动方向, 这个协议所有方法都是可选, 有默认实现

## Q:实现一个10行列表, 每行随机显示一个0 - 100 的证书, 用户可以删除, 移动任何一行, 下拉列表数字重新刷新

代码实现

## Q:UICollectionView中的Supplementary Views和Decoration Views分别指什么

Cells, Supplementary Views和Decoration Views共同构成了整个UICollectionView视图. Cells是最基本的, 并且必须由用户实现并配置, 而Supplementary Views和Decoration Views有默认实现, 主要用来梅花UICollectionView.

- Supplementary Views是补充视图. 一般用于设置每个section的Header View或者Footer View, 以及用于标记section的View
- Decoration Views是装饰视图.它是完全与数据没有关系的视图, 负责给cell或者Supplementary Views添加辅助视图
- Supplementary Views的布局一般可以再UICollectionViewFlowLayout中实现完成. 如果要定制化实现supplementary Views 和 Decoration Views, 就要实现UICollectionViewLayout抽象类

## Q:如果一个列表视图滑动很慢, 那么应该怎么优化

一般是UI或是数据出现问题

分析问题:

- 列表渲染时间长界面渲染后, 大量的操作或者耗时计算阻塞了主线成
- 数据源问题, 可能是因为网络加载太慢, 不能及时得到数据, 也有可能是需要更新的数据太多,  主线程一时处理不过来.

优化问题:

- 先检查Cell是否服用, 对于复杂的视图, 可以采用惰性加载来推迟创建时间, 尽量减少视图的层级也是很好的优化方法, , 减少圆角, 由UI切好直接添加进去, 用frame布局, UI空间复杂或者层级较多, 应减少
- 对于第二个问题, 可以用gcd多线程操作将复杂的计算放到后端线程, 并运行缓存. 列如, 对于布局计算或非UI对象的创建就可以如此操作
- 对于第三个问题, 建议将网络数据缓存并存储在手机端, 将取得的部分数据优先级进行顺序渲染, 还可以优化服务器端的网络请求

另外, 对于界面渲染和优化, 其实[Texture](https://github.com/TextureGroup/Texture)是最好的解决方案, 该库从底层重新写UI的刷新, 数据加载等, 将这些功能移出主线程可以异步进行耗时操作

## Q:说一说实现预加载的方法

实际开发中, 当列表滑动到一定程度后, 就需要发送网络请求, 以获得新的数据, 网络请求是一种耗时的操作, 为了提高用户体验, 开发者经常运用预加载方式提前发送网络请求, 这样可以在用户滑动在列表底部之前获得最新数据, 无须让用户等待, 这就是无限滚动列表.

预加载原理就是, 根据当前UITableView所在位置除以整个contentView的高度, 以判断当前位置是否超过Threshold, 如果超过, 就发送网络请求, 获得数据

具体见实现代码

这中解决方法缺点十分明显:

会出现新加载的页面还没有被访问, 应用程序就发送另一次网络请求的情况.

列如:假设Threshold阈值是0.7, 当前是28, 则已加载了40条数据, 开始请求40 - 50的cell数据, 可是之前加载的30 - 39的cell数据还没有被访问, 此时发送网络请求就造成了浪费.

解决方法是将Threshold变成一个动态的值, 随之数据的增长而增长

具体见实现代码

## Q:如何用UICollectionView实现瀑布流界面

代码实现




