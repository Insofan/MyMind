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

## Q: 说明并比较关键词： aotomic和nonatomidep

- aotmic修饰的对象会保证setter和getter的完整性，任何线程访问它都可以得到一个完整的初始化后的对象， 因为要保证线程安全，所以速度比较慢， automic比nonatomic安全， 但也不是绝对的线程安全。 例： 多个线程同时调用set和get时， 就会导致获得的对象值不一样， 要想绝对的线程安全， 要用@synchronize。
- nonatomic修饰的对象不保证setter和getter的完整性， 所以， 当多个线程访问它时， 它可能返回未初始化的对象， 正因为如此， nonatomic比atomic速度快， 但是线程不安全。

## Q: 说明并比较关键词：__weak 和_ _block

- __weak与weak基本相同， 前者是用来修饰变量， 后者使用来修饰属性 property， _ _weak主要用来防止block中的循环引用
- _ _block用于修饰变量，它是引用修饰， 所以， 其修饰的值是动态变化的， 即可以被重新赋值， _ _block主要用于修饰block内部将要修改的外部变量

## Q: 什么是block？它和代理的区别是什么

block结构上类似函数指针。block和代理都是回调的方式， block是一段封装好的代码， 代理的声明和实现一般分开， 比如UITableDelegate， 就是代理的声明在UITableView中， 实现在某个UIViewController中。

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

## Q:内存管![](https://upload-images.jianshu.io/upload_images/852671-43a595a0c0c52a31.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)理语法考查

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

## Q:以scheduledTimerWithTimeInterval的方式出发的timer， 在滑动页面上的列表时， tiTelnet协议: 远程登录协议, 基于TCP协议, 端口号23mer会暂停， 为什么？该如何解决

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

## Q:说一说HTTP中GET与POST区别

- 从方向上来看, Get是从服务器获取信息的, Post是向服务器发送信息的
- 从类型上来看, Get是获取动态内容和静态内容的, Post只负责动态内容
- 从参数位置来看, Get的参数在URI里, Post的参数在其包体里. 从这个角度可以说Post比Get安全, 隐秘
- Get可以被缓存, 可以存储在浏览器历史中, 内容理论上有长度限制. Post则相反

## Q:说一说Session和Cookie的概念

Http是无状态的,  session和cookie用来控制会话

- Session是服务器端用来认证, 追踪用户的数据结构. 它通过用户传过来的信息确定用户, 确定用户唯一标识是sessionID
- Cookie是客户端用来保存用户信息的机制. http协议会在初次会话时存储一个seesionID, 每次会话时将sessionID发送给服务器
- Session一般用来用户验证, 它默认存储在一个文件里, 也可以内存或者数据库中
- 如果客户端禁用了cookie, 则客户端会采用URL重写技术, 每次会话在URL末尾加上sessionID 发送给服务器

## Q:说明并比较网络通信协议: Ajax Polling, Long Polling, WebSockets和Server-Sent Event

- Ajax Polling: 最基本的通信协议, 其逻辑时客户端不停的向服务器发送请求, 等待服务器返回数据, 若是没有数据, 服务器会返回空值. 其优点是:服务器处理简单, 浏览器兼容性好. 缺点是: 延时长, 浪费宽带流量, 大多数响应是空响应.
- Long Polling: 其请求方式与Ajax Polling类似, 不同点在于服务器端在没有可用数据返回时, 会将其挂起, 直到有可用数据返回. 所一Long Polling 一旦请求, 一定会返回有效数据. 其优点在于轮询次数少, 没有响应不会返回数据. 缺点:缺点请求会超时, 需要不断重连, 同时, 因为请求总是被挂起, 所以服务器一直保持大量连接
- WebSocket:一次请求过后, 服务器客户端之间就保持了双向TCP连接 , 客户端和服务器可以互相传输数据. 其优点: 延时短, 开销小, 完全可以替代 Ajax Polling, Long Polling, 缺点: 浏览器不兼容
- Server-Sent Event(SSE): 其主要用于服务器向客户端传输数据, 一旦连接, 一直稳定打开, 直到客户端关闭. 相比 WebSocket, SSE优点: 可以自动重连, 可以发送任何事件, 缺点是SSE只是单向的信息传递

## 在一个HTTPS连接的网络中, 输入账号和密码并单击登陆后, 到服务器返回这个请求前, 这期间经历了什么

 这期间一共经历了8部分

1. ##### 客户端打包请求:
     其中包括URL, 端口, 账号密码等, 使用Post方式将用户的账号密码加载到body里. 这个请求应该包含3方面:网络地址, 协议和资源路径

2. ##### 服务器接受请求
     一般客户端的请求会先发送到DNS服务器中, DNS服务器将地址解析成IP地址, 这个IP地址对应一台计算机, 信息到达服务器后, 服务器和客户端会建立一个socket连接, socket 以file descriptor的方式来解析这个请求. 这个过程相当于服务器解析是否需要向客户端发送钥匙模板

3. ##### 服务器端返回数字证书
     服务器将一套数字证书(相当于钥匙模板), 这个证书会被发送给客户端. 这个过程相当于服务器向客户端发送钥匙模板.

4. ##### 客户端生成加密信息
     客户端根据数字证书(钥匙模板), 客户端会生成钥匙, 并把内容加锁, 此时信息已经被加密, 这个过程相当于客户端生成钥匙并锁上请求

5. ##### 客户端发送加密信息
     服务器端会收到由自己发送的数字证书加锁的信息. 这个时候生成的钥匙也一并被送到服务器. 这个过程相当于客户端发送请求

6. ##### 服务器端解锁加密信息
     服务器端收到加密信息后, 会根据得到的钥匙进行解密, 并把要返回的数据进行对称加密. 这个过成相当于服务器解锁请求, 生成信息并加锁

7. ##### 服务器端向客户端返回信息
     服务器端发送加密信息. 这个过程相当于服务器端向客户端发送回应信息

8. ##### 客户端解锁返回信息
     客户端会用刚生成的钥匙解密信息, 并显示在浏览器上

## Q:说明并比较类:URLSessionTask, URLSessionDataTask, URLSessionUploadTask和URLSessionDownloadTask

- URLSessionTask 是一个抽象类. 通过实现它, 可以实例化任意网络传输任务, 列如请求, 上传, 下载.它的cancel, resume, suspend都有默认实现
- URLSessionDataTask负责HTTP Get请求, 它是URLSessionTask的具体实现, 一般用与从服务器获取数据并存在内存中
- URLSessionUploadTask负责HTTP Post/Put请求, 他继承了URLSessionDataTask类, 一般用于上传
- URLSessionDownloadTask负责下载数据, 它是URLSessionTask的具体实现, 它一般将下载的数据保存在一个临时文件中, 在取消后可以将数据保存, 之后继续下载

## Q:什么是Completion Handler

Completion Handler 一般用于API请求之后返回的数据

当URLSessionTask结束之后, 无论是成功还是报错, Completion Handler 一般都会接收三个可选参数, Data, URLResponse, Error

## Q:设计一个方法, 在给定API的网址的条件下, 返回用户数据

代码实现一个网络请求, 测试URLSessionDataTask的基本用法

## Q:在iOS开发中, 本地消息通知的流程是怎样的

UserNotifications 框架是针对远程和本地推送的框架, 其主要流程分为一下四步

1. ##### 注册
     通过requestAuthorization这个方法, 通知中心会向用户发送通知许可请求. 用户点击同意按钮, 即可完成注册

2. ##### 创建
     首先设置消息内容 UNMutableNotificationContent 和触发机制UNNotificationTrigger, 然后用这两个值来创建UNNotificationRequest, 最后将request加入到当前通知中心UNUserNotificationCenter.current()中. 远程通知与本地通知大同小异, 远程通知的消息内容和消息创建都在服务器端完成, 而不是本地完成

3. ##### 推送
     这一步就是系统或者远程推送通知的过程, 收到通知后, 通知会根据对应UI显示在手机上

4. ##### 响应
     用户看到通知后, 点击通知后看到响应的响应选项, UNNotifictionAction和UNNotificationCategory用于响应设置

## Q:说一说在iOS开发中, 远程消息推送的原理

主要是App, 服务器和APNs间的关系

1. App通过requestAuthorization向iOS申请远程推送权限, 基本和本地推送一样
2. iOS系统向APNs服务器请求手机端的deviceToken, 并告诉App, 允许接受推送的通知
3. App接收到手机端的deviceToken
4. App将受到的deviceToken传给APP对应的服务器
5. 远程消息由App对应服务器端产生, 它会先经过APNs服务器
6. APNs服务器将远程推送推送给对应App
7. 根据对应的deviceToken, 推送给指定手机
可以看一下书上图, 很经典

## Q:在iOS开发中, 如何实现编码和解码

代码实现

## Q:说一说在iOS开发中数据持久化的方案

- Plist:他是一个XML文件, 会将某些固定类型的数据存放于其中, 读写分别通过contentOfFile和writeToFile来完成. Plist一般用于保存App的基本设置
- Preference:它通过UserDefaults来完成key-value配对保存. 如果保存用synchronize方法, 他会将数据保存在一个pilist文件下. Preference同样用于保存App的基本信息
- NSKeyedArchiver:遵循NSCoding协议的对象就可以实现序列化. NSCoding有两个必要实现的方法, 即父档的归档(initWithCoder 方法)和接档(encodeWithCoder方法). 存储数据通过NSKeyedArchiver的工厂方法archiveRootObject:toFile:来实现, 数据读取通过NSKeyedUnarchiver的工厂方法, unarchiveObjectwithFile:来实现. 相比前两者, NSKeyedArchive可以任意指定文件存储的位置和文件名.
- CoreData:前面集中方法都是覆盖存储, 在修改数据时要读取整个文件, 修改后再覆盖写入, 十分不适合大量的数据存储. CoreData就是苹果公司推出的大规模数据持久化方案. 它的基本逻辑和SQL数据库, 每个表Entity, 可以添加, 读取, 修改, 删除对象实例. 他可以像SQL一样提供模糊搜索, 过滤搜索, 表关联等复杂操作, 虽然CoreData功能强大, 但也有缺点, 即学习曲线高, 操作复杂.

## Q:多线程在iOS开发中有哪三种方式

- NSThread:可以最大限度的掌握每一个线程的生命周期, 但是也需要开发这手动管理所有的线程活动, 比如创建, 同步, 暂停, 取消等, 其中手动加锁操作的挑战性很大.NSThread总体使用场景很小, 基本是在开发底层的开源软件或是测试时使用
- GCD:苹果公司推荐的方式, 他将线程管理给了系统, 用的是名为Dispatch Queue的队列; 开发这只要定义每个线程需要执行的工作即可, 所有的工作都是先进先出, 每一个block运行速度极快(纳秒). 使用GCD主要是为了追求高效处理大并发数据, 如图片异步加载, 网络请求等
- Operations:与GCD类似, 虽然是Operation Queue队列实现, 但是他并不局限于先进先出的队列操作, Operation提供了多个接口可以实现暂停, 继续, 终止, 优先顺序, 依赖等操作, 比GCD更灵活. Operations的应用场景最广, 在效率上Operation处理速度较快(毫秒), 几乎所有的基本线程操作都可以实现.

## Q:比较关键词:Serial, Concurrent, Sync和Async

  Serial/Concurrent:串行, 并行 
- 串行:指在同一时间内, 队列中只能执行一个任务,  当前任务执行完成后才能执行下一个任务. 串行队列中只有一个线程
- 并行:允许多个任务在同一个时间内进行, 在并行队列中有多个线程,\
- 串行队列的任务一定是按开始顺序结束, 并行队列的任务不一定会

Sync/Async:同步, 异步

- 同步: 会把当前任务加到队列中, 等任务执行完成, 线程才会返回继续运行, 同步会阻塞线程
- 异步: 也会把当前的任务加到队列中, 但他会立即返回 , 并不会等任务执行完成

注意: 在串行队列中执行同步操作容易造成死锁, 并行队列中不担心这个问题. 异步操作无论是在串行队列中执行还是并行队列中执行, 都可能出现竞争问题.

## Q:串行队列的代码实战

代码实现, 串行同步, 串行异步, 死锁条件, 串行中进行异步, 同步嵌套

## Q:并行队列的代码实现

代码实现, 注意死锁条件

## Q:距离说明iOS并发变成中的三大问题

三大问题: 竞争条件, 优先倒置, 死锁问题

- 竞争条件:指两个或连个以上线程对共享数据进行读写操作时, 最终的数据结果不确定

- ```swift
  var num = 0
  DispatchQueue.globa().async {
      for _ in 1..10000 {
          num += 1
      }
  }
  
  for _ in 1..10000 {
      num += 1
  }
  ```

最后的计算结果num很有可能小鱼20000, 因为其操作为非原子操作, 在上述两个线程对num进行读写, 其值会随着执行顺序的不同而产生不同结果

- 优先倒置:指低优先级的任务会因为各种原因高于优先级的任务执行. 例如:

- ```swift
  var highPriorityQueue = DispatchQueue.global(qos: .userInitiated)
  var lowPriorityQueue = DispatchQueue.global(qos: .utility)
  
  let semaphore = DispatchSemaphore(value: 1)
  
  lowPriorityQueue.async{
      semaphore.wait()
      for i in 0...10 {
          print(i)
      }
      semaphore.signal()
  }
  
  highPriorityQueue.async {
      semaphore.wait()
      for i in 11...20 {
          print(i)
      }
      semaphore.signal()
  }
  ```

以上代码如果没有semaphore, 则高优先级的highPriorityQueue会优先执行, 所以程序会优先打印完成11~20. 而加了semaphore之后, 低优先级的lowPriorityQueue会先挂起semaphore, 而高优先级的PriorityQueue就只有等semaphore被释放才能执行打印操作, 

也就是说, 低优先级的线程可以锁上某种高优先级的线程需要的资源, 从而使高优先级的需要等低优先级执行玩

- 死锁问题: 指两个或两个以上的线程, 他们之间互相等待彼此停止执行, 以获得某种资源, 但是没有一方提前退出的情况, 在iOS开发中, 有一个经典的例子就是两个Operation互相依赖

  ```
  let operationA = Operation()
  let operationB = Operation()
  
  operationA.addDependecy(operationB)
  operationB.addDependecy(operationA)
  
  //最经典的, 对一个串行队列进行异步, 同步嵌套, 
  serialQueue.async {
      serialQueue.sync {
          
      }
  }
  因为串行队列一次只能执行一个任务, 所以, 首先会把异步block中的任务派发执行, 当进入block中时, 同步操作意味这阻塞当前队列, 而此时外部block正在等待内部block操作完成, 而内部block又阻塞其操作完成, 即内部block在等待外部block操作完成. 所以, 串行队列在等待自己释放资源, 构成死锁, 也提醒我们, 千万不要在主线程进行同步操作
  //主线程同步死锁
  https://www.jianshu.com/p/8ab497e39eb5
  ```

## Q:竞态条件的代码实战

代码实现, 用barrier flag 保证并行队列只进行当前的写操作, 而无视其他操作

## Q:试比较GCD中的方法: dispatch_async, dispatch_after, dispatch_once和dispatch_group

- dispatch_async:用于对某个线程异步操作. 异步操作可以让我们在不阻塞线程的情况下, 充分利用不同线程和队列来处理任务. 例如, 当需要从网络端下载图片, 然后将某个图片赋予给某个UIImageView时, 就可以用到dispatch_async

  ```objective-c
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH), 0), ^{
  	UIImage *image = [client fetchImageFromURL: url];
  	dispatch_async(dispatch_get_main_queue(), ^{
      	self.imageView.image = image;
  	});
  });
  ```

- dispatch_after:一般用于延时操作, 例如将一个页面的导航标题在两秒钟后更改

  ```
  self.title = @"等待";
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NS_PER_SEC));
  dispatch_after(popTime, dispatch_main_queue(), ^(void){
     	self.title = @"完成"; 
  });
  ```

- dispatch_once:用于确保线程安全的单例子, 它表示修饰的区域只会访问一次, 这样在多线程的情况下, 类也只会初始化一次, 确保了Objective-C中单例的原子化.

  ```objective-c
  + (instancetype)sharedManager {
      static Manager *sharedManager = nil;
  	static dispatch_once_t onceToken;
  	dispatch_once(&onceToken, ^{
         sharedManager = [Manager new]; 
  	});
  	return sharedManager;
  }
  ```

- dispatch_group:一般用于多个任务同步. 一般用法是当多个任务关联到同一个群组(group)后, 所有的任务在执行后, 再执行一个统一的后续工作. 注意. dispatch_group_wait是一个同步操作他会阻塞线程

  ```
  dispatch_group_t group = dispatch_group_create();
  
  dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSLog(@"任务1"); 
  });
  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSLog(@"任务2"); 
  });
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
  	NSLog(@"任务1和任务2都完成了");
  });
  ```

## Q:GCD中全局(global)有哪儿几种优先级

  全局global默认时并发队列, 如果不指定优先级, 则为默认default优先级, 共有background, utility, default ,user-Initialted, user-Interactive, unspecified.

- background: 用来处理特别耗时的后台操作, 如同步,备份数据

- utility: 用来处理一些需要时间, 而又不用立即返回结果的操作. 其特别适用于异步操作, 例如下载, 导入数据.

- default: 默认优先级, 一般来说开发者应该指定优先级, default属于特殊情况

- user-Initiated: 用来处理用户触发的需要立刻返回结果的操作, 比如, 打开用户点击的文件

- user_Interactive:用来处理与用户交互的操作. 其一般用于主线程, 如果不及时响应, 有可能阻塞主线程

- unspecified: 未确定优先级, 由系统根据不同环境推断, 如, 使用过时的API不支持优先级时, 就可以设定为未确定优先级, unspecified属于特殊操作.

## Q:试比较Operation中的关键词:Operation, OperationBlock和OperationQueue

Operation是iOS中除GCD之外另一种并发变成, 他将单个任务作为一个Operation, 放在OperationQueue中进行管理和运行

- Opeartion: 指一系列任务和工作, Operation是一个抽象类, 一般通过它来集成完成自定义的任务, 一个Operation有四个状态: Ready, executing, cancelled, finished.
- BlockOperation: 它是Operation的子类, 它在默认权限的全局队列上运行, 负责执行多个任务, 它可以向dispatch_group一样同步管理多个任务.
- OperationQueue: 负责安排多个Operation的队列, 但它并不局限于FIFO, 它提供了多个接口可以实现, 暂停, 继续, 终止, 依赖等复杂操作, 还可以通过maxConcurrentOperationCount来设置是否串行或者并行.

## Q:如何在OperationQueue中取消某个Operation

在Operation抽象类中, 有一个cancel()方法, 它做的唯一一个工作就是将Operation的isCancelled属性变成true, 但并不会真正的深入代码暂停具体某个工作, 所以要利用isCancelled属性变化来暂停工作

代码实现

## Q:在实际开发中, 主线程和其他线程有哪些应用场景

主线程一般负责UI的相关操作, 如绘图布局等, 很多UIKit控件如果不在主线程中执行会产生未知效果, 可以在Xcode中通过Main Thread Checker来检测

其他线程一般负责耗时工作, 如数据解析, 复杂操作, 图片的解码编码等工作, 如果放在主线程中, 因为主线程是串行队列, 会阻塞主线程的UI操作, 影响用户体验

## Q:说说你平常开发中用到的设计模式

- 装饰模式(Decorator): 它可以在不修改源代码的基础上进行拓展, 注意他与继承的最大区别是, 继承可以修改父类, 而装饰模式不希望如此
- 适配模式(Adapter): 它可以将一个类的接口转换成另一个类的接口, 使得原本互不相容的类可以通过接口一起工作
- 外观模式(Facade): 它用一个公共接口来提供多个类和其他数据类型, 公共接口让多个类互相之间保持独立, 解耦性良好. 同时, 使用接口时, 外部无须理解其背后的复杂逻辑, 另外就算接口背后的逻辑改变, 也不影响接口的使用
- 单例模式(Singleton): 此模式保证对于一个特有类, 只有一个公共的实例存在. 它一般与懒加载一起出现, 只有被需要时才会创建, 单例模式里自由, UserDefaults. UIApplication等
- 观察者模式(Observer): 它定义对象之间的一种一对多的依赖关系, 每当对象发生变化是, 其相关依赖对象得到通知并自动更新. iOS典型就是KVO和NotificationCenter
- 备忘录模式(Memento): 它在不破坏的前提下, 它捕获一个对象的内部状态, 并在该对象之外保存状态, 这样以后就可以将该对象恢复到保存之前的状态  (Plist存密码)

## Q:操作系统的基本类型

操作系统的基本类型包括: 批处理系统, 分时系统, 实时系统

1. 批处理系统: 用户提交作业后, 作业成批处理, 多道程序运行. 
    优点: 系统被多道程序共享, 提高了系统的利用率和作业的吞吐量
    缺点: 无交互, 运行周期长.
2. 分时系统: 采用时间片轮方式, 多个用户使用终端
    优点: 多用户交互性强, 独立性强, UNIX操作系统就是一种多用户分时操作系统
3. 实时系统: 具有即使响应和可靠性, 但比分时, 批处理系统, 系统资源利用率低

## Q: 进程和线程的基本概念

进程: 进程是具有独立功能的程序在某个数据集合上的一次执行过程, 进程是系统调度分配资源的独立单位

线程: 线程是进程内执行实体或执行单元, 是比进程更小能独立运行的基本单元

现代操作系统中, 资源申请的基本单位是进程, 进程由程序员数据和PCB组成

## Q: 进程和线程的区别

1. 进程是系统资源分配和调度的单位, 线程是处理机调度和分配的单位, 资源分配给进程, 线程只有很少的资源, 切换线程代价要比切换进程低

2. 不同进程的地址空间相互独立, 同一进程内的线程分享同一地址空间

3. 创建销毁进程时的系统开销远大于创建销毁线程的基本开销

## Q:进程和程序区别

1. 进程是动态概念, 程序是静态概念
2. 进程是竞争系统资源的基本单位. 程序不反应也不会竞争计算机的系统资源
3. 不同的进程可以包含同一程序, 只要改程序所对应的数据集不同

## Q:什么是进程互斥

现代操作系统中, 很多进程可以共享资源, 但很多资源一次只能给一个进程使用, 这些资源被称为临界资源, 在每一个进程中访问临界资源的代码成为临界区

## Q:进程的状态及其转换

进程的5种基本状态

1. 初始状态
2. 执行状态: 当进程获得处理机, 正在处理机上执行, 此时进程状态成为执行状态
3. 阻塞状态: 进程因等待某个事件发生, 放弃处理机进入阻塞状态
4. 就绪状态: 进程已得到cpu之外的资源, 只要调度处理机, 便可进入执行状态
5. 终止状态

## Q:死锁概念

所谓死锁是指多个并发进程, 各自持有资源并等待特别的进程释放所拥有资源, 在未改变这种状态之前不能向前推进, 这种状态成为死锁

## Q:死锁产生条件

1. 互斥条件: 并发进程所需要的资源一次只能被一个进程占有
2. 不剥夺条件: 进程已经获得的资源, 在未使用完成前, 不可被剥夺
3. 占有并等待: 进程在等待新资源过程中, 继续占有原有资源
4. 环路条件:若干进程形成首尾相连的循环链, 循环等待上一个进程释放资源

只要发生死锁, 必然满足上述4个条件都成立, 任一条件不满足都不会产生死锁

## Q:现代操作系统的存储方式

页式管理, 段式管理, 段页式管理

1. 页式管理: 将进程的虚拟空间划分成长度相等的页, 内存空间页划分成大小相等的页面
2. 段式管理: 段式管理把内存地址空间划分成相等的段,  逻辑地址空间由一组段组成, 每个段有段名称和段偏移量, 通过地址映射吧虚拟地址转换我物理地址
3. 段页式: 将分段和分页两种方式结合起来. 

## Q:分页和分段的区别

1. 页是信息的物理单位, 分页是为了实现连续的分配方式, 以消减内存的碎片, 提高内存的使用率
2. 段是信息的逻辑单位, 包含一组完整的信息, 更好地满足用户的需求
3. 页的大小固定且由系统决定, 由系统把逻辑地址划分成页号和业内地址两部分
4. 段的大小由程序决定

## Q: 文件管理

分为连续文件, 串联文件和索引文件

1. 连续文件:  优点: 物理存取较快 缺点: 建立文件时必须指定文件长度, 不能动态扩展, 文件被删除后无法使用零头空间
2. 串联文件: 采用非连续的物理块来存放文件信息, 串联文件搜索效率低, 不适宜随机存取
3.  索引文件: 将文件的存储信息的逻辑块号和物理块号组成索引, 从而便于文件的读取

## Q: 索引文件

1. 索引结构下系统会为每一个文件建立一个索引表
2. 索引表存储文件的逻辑块和物理块的信息
3. 索引文件既可以顺序存取, 又可以随机存取
4. 满足文件动态增长, 插入删除的需求
5.  缺点增减了索引文件, 减少了存储空间

## Q: 进程间通信

1. 信号量: 它是一个卓有成效的同步工具, 可以实现线程间的同步和互斥, 由于其交换的信息量少而被称为低级通信
2. 共享存储器系统: 互相通信的进程间存在一块可直接访问的共享空间，通过对这篇共享空间的读写来实现进程间的消息交换
3. 消息传递: 消息传递系统是最为广泛的一种进程间通信机制，进程间数据交换是以格式化的消息为单位
4. 管道通信: 是指用于连接一个读进程和一个写进程以实现它们之间通信的一个共享文件. 向管道提供输入的写进程, 而接受管道输出的读进程, 从管道中接受数据, 从而实现通信

## Q: 虚拟内存的概念

虚拟内存是具有调入功能和置换功能, 能从逻辑上对内存容量增加的一种存储系统,  其运行速度接近于内存速度, 但成本接近于外存, 是一种非常优秀的存储管理技术.

## Q: 虚拟内存的应用背景

虚拟内存的应用背景: 当作业很大时, 其要求的内存空间超过了内存的总容量, 作业不能全部装入内存运行; 多道作业运行, 内存不足以容纳所有的作业, 导致大量作业在外村等待. 

这种一次性装入以及作业装入后, 即使部分模块执行完成但整个作业没有完成, 还是会一直驻留在内存中, 占用了大量内存空间. 虚拟内存就是解决这种大作业的问题.

## Q: 虚拟内存可行性

根据程序运行的局部性原理: 在一段时间内, 程序执行仅限于某个部分, 相应地, 他所访问的存储空间也局限于某个区域.

## Q: 虚拟内存的主要技术

请求调入页(段)技术, 置换页(段)技术

## Q: 关系模型的完整性

关系模型的完整性是对关系模型的约束:

1. 实体完整性: 必须要有主键, 且主键必须唯一且不能为空
2. 参照完整性: 维护实体之间的引用关系, 外键可以为空, 或者其值位被参照关系对应的主键
3. 用户定义的完整性: 由应用环境决定, 针对具体关系数据库的约束条件.

## Q: 常用SQL语句分类

- 数据定义: create, alter, drop
- 数据操纵: select, insert, update, delete
- 数据控制: grant, revoke

## Q: 视图

视图是一个虚拟的表, 是由select语句组成的查询定义的虚拟表

## Q: 数据库范式

范式是在关系数据库中对关系型数据库中减少冗余和对数据库进行优化的过程

1NF: 关系模型中每一个属性值都是不可再分割的最小数据单位

2NF: 在第一范式的条件下, 所有非主键字段完全依赖于任意一个主关键字, 即不存在依赖组合关键字中的部分关键字情况, 特例是, 如果是单关键字至少是2NF

3NF: 在关系模型中, 不存在传递依赖, 即不存在非主关键字之间的依赖关系, 即某个属性既依赖于主键, 又同时依赖于其他非主键字

## Q: 数据规范化优点/缺点

规范化优点: 避免了大量的冗余数据, 保持数据一致性, 如果完全达到3NF, 不会在超过一个地方修改同一个值

缺点: 把信息放在不同的表中, 增加操作的难度, 把多个表连接在一起的开销会影响性能

## Q: 索引的概念

类似于字典的索引, 通过索引, 数据库无须扫描整个表就可以在其中找到数据, 因此索引可以大大提高数据检索的效率.

## Q: 索引的类型

按照数据表中的记录存储顺序可分为: 聚簇索引, 非聚簇索引

聚簇索引: 指明数据的物理存储顺序的索引, 建立聚簇索引, 数据会按照索引的顺序来存放, 每个表只能建一个聚簇索引

非聚簇索引: 非聚簇索引完全独立于数据行, 其叶节点存储了组成非聚簇索引的关键字和行指针, 不影响数据存储顺序, 通过指针定位数据, 改变一个建立非聚簇索引的表中的数据时, 需要更新索引, 若一个表需要频繁更新数据, 不要建太多非聚簇索引, 一个表可以建多个非聚簇索引

## Q: 索引按是否有相同值分类

唯一索引Unique: 唯一索引可以为空, 但只要存在数据必须唯一

普通索引: 可以有相同的索引值

## Q: 索引的优点/缺点

优点:

1. 通过创建唯一性索引, 可以保证数据库表中每一行数据的唯一性
2. 加快数据的检索速度, 建索引主要原因
3. 加速表与表之间的连接, 特别是在实现数据的参照完整性方面特别有意义
4. 减少分组和排序的时间

缺点:

1. 创建索引要消耗时间, 这种时间随着数据增大而增大
2. 索引需要额外的物理空间, 每一个索引要占一定的物理空间, 如果建非聚簇

3. 对标中进行增查删改时, 索引也要维护, 降低了数据的维护速度

## Q: 事务概念

事务是作为逻辑单元执行的一组操作, 是一个不可分割的整体, 任何一个语句操作失败, 都会rollback回操作之前的状态.

## Q: 事务的四个属性

1. 原子性: 事务是不可分割的单元, 所有操作都成功才算成功, 任何一个失败会rollback.
2. 一致性: 事务不能破坏关系数据的完整性以及业务上的一致性
3. 隔离性: 在并发环境中, 不同的事务操作相同的数据, 每个事务都有各自的数据空间, 采用锁机制, 当多个事务更新数据库中的临界数据时, 只允许持有锁的事务才能更新数据, 其他事务必须等待.
4. 持久性: 只要事务成功, 它对数据库的更新就永久保存

## Q: 存储过程的优缺点

例子: PROCEDURE

```
CREATE` `PROCEDURE` `order_tot_amt
@o_id ``int``,
@p_tot ``int` `output
AS
SELECT` `@p_tot = ``sum``(Unitprice*Quantity)
FROM` `orderdetails
WHERE` `orderid=@o_id
GO
```

优点: SQL语句的执行性能会得到提高, 充分利用数据库本身的优越性, 逻辑的修改能迅速发布

缺点: 调试存在困难,不可移植

## Q: OSI七层参考模型

OSI七层

| 层数 |    名称    |          基本功能          |    对应设备    |
| :--: | :--------: | :------------------------: | :------------: |
| 7层  |   应用层   |        具体应用服务        |      软件      |
| 6层  |   表示层   | 数据的表达及数据格式的交换 |      软件      |
| 5层  |   会话层   |          会话控制          |      软件      |
| 4层  |   传输层   |      保证端到端的传输      |      软件      |
| 3层  |   网络层   |      负责网间两点可达      |     路由器     |
| 2层  | 数据链路层 |      负责内部帧的传输      |  网桥, 交换机  |
| 1层  |   物理层   |    负责链路层上比特传输    | 中继器, 集线器 |

## Q: 分层优点

1. 各层间相互独立, 如果一层发生了变化, 不会影响其它层
2. 使网络易于实现和维护, 不同层实现功能, 一旦某一层发生故障更加容易定位
3. 促进标准化工作, 由于标准统一, 便于互联互通

## Q: TCP/IP四层

| TCP/IP模型 |      OSI参考模型       |
| :--------: | :--------------------: |
|   应用层   | 应用层, 表示层, 会话层 |
|   传输层   |         传输层         |
|   网络层   |         网络层         |
|   链路层   |   数据链路层, 物理层   |

## Q: TCP/IP每层的主要协议

应用层主要协议:

1. Telnet协议: 远程登录协议, 基于TCP协议, 端口号为23
2. FTP协议: 文件传输协议, 基于TCP协议, 控制端口号21, 数据端口号20
3. HTTP协议: 超文本传输协议, 基于TCP协议, 端口号位80
4. SMTP协议: 简单邮件传输协议, 基于TCP协议, 端口号为24
5. SNMP协议: 简单网络管理协议, 基于UDP协议, 端口号位161

传输层主要协议:

1. TCP协议: 面向连接的网络传输协议
2. UDP协议: 无连接协议, 只负责数据包发送

网络层主要协议:

1. IP协议: 负责网间路由
2. ARP协议: 负责2~3层之间地址转换
3. ICMP协议: (Internet Control Manage Protocol): 负责因特网控制管理

链路层主要协议:

1. 没有定义协议. 之所以不定义协议是为了增强TCP/Ip的协议栈可扩展性

## Q: 常用状态码

1. 1XX: Infomational（信息性状态码）接收的请求正在处理
2. 2XX：Success（成功状态码）请求正常处理完毕
3. 3XX：Redirection（重定向状态码）需要进行附加操作以完成请求
4. 4XX：Client Error（客户端错误状态码）服务器无法处理请求
5. 5XX：Server Error（服务器错误状态码）服务器处理请求出错

200 OK:

正常处理

204 No Content:

请求成功处理, 但是没有实体的主体部分.

206 Partial Content:

表示客户端进行了范围请求, 而服务器成功执行了这部分GET请求, 响应报文中含有Content-Range指定范围的实体部分



301 Moved Permanently:

永久重定向, 被请求的资源已经永久移动到新位置

302 Found:

临时性重定向, 可以做临时跳转, 访问404页面会自动重定向到首页

304 Not Modified:

该状态表示客户端发送附带条件的请求时, 服务端允许请求访问资源, 但未满足条件的情况

307 Temporary Redirect:

临时重定向类似于302 Found



400 Bad Request:

状态码表示请求报文中存在错误, 当错误发生时, 修改请求内容再次发送

401 Unauthorized:

表示发送的请求需要通过HTTP认证的信息, 首次请求会弹出用户认真对话框

403 Forbidden:

该状态码表示请求资源被服务器拒绝

404 Not Found:

该状态码表示服务器上无法找到请求的资源, 也可以在服务器端拒绝请求且不想说明理由时使用



500 Internal Server Error:

该状态码表示服务器在执行请求时发生了错误, 也可能是Web应用存在bug或故障

502 Bad Gateway:

从上游服务器（如tomcat、php-fpm）中接收到的响应是无效的

503 Service Unavailable:

该状态码表明服务器暂时处于负荷或正在进行停机维护, 现在无法处理请求

504 Gateway Timeout:

表示扮演网关或者代理的服务器在规定时间内无法获得想要的响应

## Q: IP协议与IP地址

IP协议: 是负责网络之间路由的协议, 属于网络层的基本协议. 网络层中数据传输的基本单位是包(packet), 它是在原有数据帧上封装一个20字节的IP头后组成的, 头中包含了源主机的IP地址和目标主机的IP地址

IP地址: IP地址是由一个32bits的二进制数表示的. 为了书写简单, 通常将其表示为点分十进制的形式

## Q: 五类IP地址

一个IP地址可以分为网络地址部分和主机地址两部分, 依据网络部分和主机部分的长度以及引导位的不同, 又可以将IP地址分为五类

| 地址类型 | 引导位 |         地址范围          | 地址结构 | 可用网络地址数 | 可以主机地址数 |
| :------: | :----: | :-----------------------: | :------: | :------------: | :------------: |
|   A类    |   0    |  1.0.0.0~126.255.255.255  | 网.主.主.主 | 2^7 | 2^24 - 2 |
|   B类    |   10   | 128.0.0.0~191.255.255.255 | 网.网.主.主 | 2^14 | 2^16 - 2 |
|   C类    |  110   | 192.0.0.0~223.255.255.255 | 网.网.网.主 | 2^21 | 2^8 - 2 |
|   D类    |  1110  | 224.0.0.0~239.255.255.255 | 一般用于组播 |||
|   E类    |  1111  | 240.0.0.0~255.255.255.255 | 一般用于研究实验 |                |                |

## Q: ARP协议

Address Resolution Protocol: 功能是将网络层IP地址(TCP 二层, OSI三层)解析成数据链路层MAC地址(TCP 一层, OSI 二层).

## Q: ICMP协议

Internet Control Manager Protocol: ICMP是附属于IP层的协议, 一般认为它介于TCP和IP层中介, 认为它属于IP层. 一般用于控制主机--路由器之间传递消息, 包括报告错误, 交换状态信息, 受限控制等. Ping就是ICMP协议.

## Q: TCP/UDP协议

TCP:是一种面向连接的网络传输协议. 在传输数据过程中, 一旦传输出现错误, 需要重传数据, 数据传输完毕需要断开数据连接. TCP保证数据包的传输不丢, 不错, 不乱徐, 是一种可靠地数据传输协议.

UDP: 是一个无连接的网络传输协议. 提供不可靠信息传递, 没有重传机制.

## Q: IPv4协议和IPv6协议

1. 为什么要退出IPv6:

IPv4是32bit的, 但是快要耗尽, 关于耗尽有三种解决方案:

1. 划分子网: 利用子网掩码将IP地址的网络部分右移, 也就是在同一网络中划分出几个不同的子网, 可以更加高效的利用IP地址
2. 保留IP地址: 公共专网地址可以再不同的单位重复使用, 但这样不能连接到Internert上

IPv6改进:

1. 支持前缀地址, 不同类型的地址有不同的前缀
2. 支持接口的自动配置
3. 支持内置的认证加密机制, 提高了安全性
4. IPv6提供了IPv4升级到IPv6的升级方式, 减少了成本消耗

最显著特点就是地址变长, 从而从根本上解决了IP地址紧张问题. 

## Q: Xcode 点击run之后发生了什么

1. 预处理器, 所有带#的都是预处理器负责的范畴: #include 导入头文件, #define将宏定义展开, #ifdef #elif #endif条件编译, 其他宏指令#error #warning #pragma
2. 编译器: 现在iOS 用的编译器是LLVM(Low Level Virtual Machine), 以前使用GCC. LLVM基本架构

![LLVM架构](https://upload-images.jianshu.io/upload_images/852671-707a44a3e73b5229.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

编译器负责词法分析, 语法分析, 语义分析, 静态分析

编译器分为前端(clang)和编译器后端, 前端负责产生和机器无关的中间代码, 后端负责将中间代码优化并转化为汇编代码.

3. 汇编器:汇编器将编译生成的汇编代码翻译成计算机可以识别的机器指令, 并生成目标文件. 
4. 链接器将所有用到的目标程序连接到一起, 无论用静态链接还是动态链接. iOS生成match-O
5. 代码签名

![](https://upload-images.jianshu.io/upload_images/852671-43a595a0c0c52a31.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

每次build会生成一个`.ipa`文件, 在_CodeSignature的子目录, 这是一个plist文件, 里面包含程序的代码签名, 程序一旦签, 就没有办法改变其中的任何东西, 包括资源文件可执行文件等

6. 启动



题外dyld动态链接器在启动过程中起了很重要的作用, 1. 加载以来的dylibs, 2. Fix-up:Rebase修正地址偏移, 因为OS X和iOS 有ASLR的机制来做地址随机化偏移来防止攻击 3. Fix-ups:Binding: 确定 Non-Lazy Pointer地址，进行符号地址绑定 4. Objc Runtime 初始化: 加载所有类 5. Initializers: 执行load 方法和_ _attribute_ _((constructor))修饰的函数

## Q: 简述下MVC

MVC, 即Model-View-Controller, 它是苹果公司推荐的App开发架构, 分成Model负责处理数据, View负责UI, Controller负责将View和Model连接.由于Controller承担的任务相对较重, 很多初级开发人员将View和Controller部分的代码全部塞到了ViewController中造成了高度耦合

## Q: Objective-C单例(Singleton)

```objective-c
- (instanceType)sharedManager {
    static Manager *shareManager = nil;
	static distance_once_t onceToken;
    dispatch_once(&onceToken, ^{
       sharedManager = [self new]; 
    });
    return sharedManager;
}
```

## Q: 什么是装饰器(Decorator)

不改变原封装的前提下, 为对象添加新功能, OC中表现为Category和Delegation. UITableViewDelegate就是典型的Delegation

## Q: 什么是观察者模式(Observer)

观察者定义对象之间一对多的依赖关系, 每一个对象状态发生改变时, 其相关依赖对象皆得到通知并自动更新. OC中表现形式为通知和KVO

## Q: 什么是备忘录模式(Memento)

备忘录, 保存对象当前的状态, 并在日后可以恢复的模式.

## Q: 比较苹果官方的MVC架构的优点和缺点

优点:

1. 代码总量少: 基本上, MVC大量逻辑和视图代码都集中在ViewController中, View和Model严格区分, 代码分配遵循一定规则
2. 简单易懂: 大部分人可以快速上手

缺点:

1. 代码过于集中: Controller将View和Controller高度耦合, 它将处理交互, 视图更新, 布局, Model数据获取和修改, 导航等所有操作
2. 难以进行测试: 由于高度耦合, 使得以检测功能为主的单元测试需要配合固定视图才能进行
3. 难以扩展: ViewController中添加新功能需要格外小心, 高度耦合逻辑结构增加了出错的风险.
4. Model过于简单:
5. 网络请求无处安放

## Q: 一个App崩溃了, 可能是什么原因造成的

一个App崩溃了, 有可能是以下几个原因

1. 代码出错: 利用了OC的动态特性, 编译时找不到错误, 运行之后程序找不到对应的实现例如unrecognized selector
2. 内存不够: 例如, App在运行时占用了手机大量的内存, 此时App就能崩溃, 通过Xcode Instruments调试判断出来
3. 网络原因:例如, 网络不佳时, App的请求得不到响应导致超时, 或者是用户量太多, 服务器端过载导致手机崩溃
4. 第三方: 第三方Bug

检测工具Bugly

## Q: 模拟器在模拟器上测试了, 就不需要在真机上再测试了么

两者差别:

- 功能方面: 模拟机不支持E-mail, 通话, 短信等功能.

- 硬件方面: 模拟机不支持照相机, 音频输入, 蓝牙等功能

## Q: 说一说iOS中的性能测试(performance test)

就是检测一个方法快慢的测试, 一般先设定一个基础值, 比如0.01s, 然后运行性能测试, 测试后会显示本次测试消耗时间及平均运行耗时, 可以与基础值进行比较, 并且设定最大上限, 比如10%. 如果测试超过最大上限, 比如0.01s * 1.1 = 0.011s那么此次测试就是败了, 性能测试一般用在分析那些可能会很耗时的方法上, 比如, 在设备上的存取操作, 网络端的请求, 复杂计算等.

## Q: 说一说iOS开发中的UI测试

首先, UI测试特殊的地方在于并不需要完全手写代码, Xcode的record功能可以自动生成UI测试代码, 只需要给出判断和代码优化即可.

## Q: 如何检查覆盖率

测试完之后, 切换到日志导航, 点击刚刚测试的结果. 然后在导航栏上点击"Coverage"选项即可得到测试覆盖率示意图. 

## Q: 什么是iOS中的App ID

每一个App都有唯一的, 独立的ID, 这就是App ID, 由Team ID和Bundle Id组成, 形式位TeamID.BundleID

Team ID指定App的开发者或开发团队. Bundle ID指定App或阈值相关一系列App. Bundle ID可以唯一确定App.

Bundle ID指定App或与之相关一系列App, Bundle ID可以唯一确定App.一个项目可以有多个Target, 对应产生多个App比如beta版, pro版, 付费版, 免费版.

## Q: 什么是iOS中的Code Signing

为了确定App是谁开发的, 并且开发之后没有被修改, 苹果引进了App Signing的机制

有了它, 从App Store上下载某个App后, iOS和Mac Os系统可以通过签名来确认此App是否有效.

只要App被修改过, 签名就认定为无效, 如果签名无效, 系统拒绝运行App, 以保证整个系统的安全性和用户体验

Code Siging 对应的签名是由一对公共密匙和私有密匙, 以及由一个App签发的证书构成, 其中私有密匙用来产生签名, 证书则包含了公共秘史并由此认定App开发者.

## Q: 什么是App Thinning

App Thinning, 中文应用瘦身, 指通过优化尽量减少安装包大小, 分三种类型, Slicing, Bitcode和On-demand Resources

- Slicing: 指根据不同的设备, App产生对应的版本, 例如, iPad版本只包含iPad版本的图片资源和布局代码
- Bicode: 是一个编译好的程序的表示形式, 再上传新版本App时, App Store会对包含Bitcode的二进制App进行优化, 而不需要提交一个新的App版本到App Store中. 在iOS中它是可选的
- On-Demand Resource: 只提供部分的App内容, 只要满足其基本运行即可, 比如某些游戏App, 一开始下载后只能玩部分内容, 如果玩家有兴趣继续, 则App Store就会解锁后续内容, 将其下载更新到游戏中.

## Q: 向App Store提交App时有哪些原因可以被拒

- 崩溃: 程序本身有Bug, 第三方服务器出错都有可能被App Store拒绝, 
- 第三方: 如果App需要安装第三方应用, 比如需要QQ登录, 而测试员手机中没有装QQ, 如果出现安装QQ信息, 就有可能被拒, 另外第三方广告, 也有可能违规
- 版权: 比如第三方客户端套用某平台的名字, 比如在App中为了提高点击和排名加入无关关键词, 或是山寨其他App的行为, App中包含没有授权的内容都会被拒绝上架
- 材料不全: 比如缺少截图, 或者使用错误的截图, 与硬件相关的App, 苹果官方没有相关硬件, 需要提供硬件相关视频

































