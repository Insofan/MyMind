# 1. cache缓存机制

## 缓存时用NSCache和NSMutableDictionry的区别

NSCache是Foundation提供的缓存类, 使用方式类似NSMutableDcitonary.但NSCache在实现缓存时更方便, 最重要NSCache是线程安全的, 而NSMutableDictionary不是线程安全的, 多线程下使用NSCache使用更好.

## NSCache

NSMutableDictionary自定义缓存时要考虑线程安全, 加锁释放锁等操作, NSCache已经帮我们做好了这一步, 其次在内存不足时NSCache会自动释放存储对象, 不需要手动干预, 而且NSCache的key不会被复制, 不需要实现NSCopying协议.

```objective-c
//定义一个CacheTest类实现NSCacheDelegate代理
@interface CacheTest: NSObject <NSCacheDelegate>

@end

@implementation CacheTest

//当缓存中的一个对象即将被删除时会回调该方法
- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    NSLog(@"Remove Object %@", obj);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //创建一个NSCache缓存对象
        NSCache *cache = [[NSCache alloc] init];
        //设置缓存中的对象个数最大为5个
        [cache setCountLimit:5];
        //创建一个CacheTest类作为NSCache对象的代理
        CacheTest *ct = [[CacheTest alloc] init];
        //设置代理
        cache.delegate = ct;
        
        //创建一个字符串类型的对象添加进缓存中，其中key为Test
        NSString *test = @"Hello, World";
        [cache setObject:test forKey:@"Test"];
        
        //遍历十次用于添加
        for (int i = 0; i < 10; i++)
        {
            [cache setObject:[NSString stringWithFormat:@"Hello%d", i] forKey:[NSString stringWithFormat:@"World%d", i]];
            NSLog(@"Add key:%@  value:%@ to Cache", [NSString stringWithFormat:@"Hello%d", i], [NSString stringWithFormat:@"World%d", i]);
        }
        
        for (int i = 0; i < 10; i++)
        {
            NSLog(@"Get value:%@ for key:%@", [cache objectForKey:[NSString stringWithFormat:@"World%d", i]], [NSString stringWithFormat:@"World%d", i]);
        }
        
        [cache removeAllObjects];
        
        for (int i = 0; i < 10; i++)
        {
            NSLog(@"Get value:%@ for key:%@", [cache objectForKey:[NSString stringWithFormat:@"World%d", i]], [NSString stringWithFormat:@"World%d", i]);
        }
        
        NSLog(@"Test %@", test);
    }
    
    return 0;
}
```

输出:

```objective-c
//第一个for循环输出
Add key:Hello0  value:World0 to Cache
Add key:Hello1  value:World1 to Cache
Add key:Hello2  value:World2 to Cache
Add key:Hello3  value:World3 to Cache
Remove Object Hello, World
Add key:Hello4  value:World4 to Cache
Remove Object Hello0
Add key:Hello5  value:World5 to Cache
Remove Object Hello1
Add key:Hello6  value:World6 to Cache
Remove Object Hello2
Add key:Hello7  value:World7 to Cache
Remove Object Hello3
Add key:Hello8  value:World8 to Cache
Remove Object Hello4
Add key:Hello9  value:World9 to Cache
//第二个for循环输出
Get value:(null) for key:World0
Get value:(null) for key:World1
Get value:(null) for key:World2
Get value:(null) for key:World3
Get value:(null) for key:World4
Get value:Hello5 for key:World5
Get value:Hello6 for key:World6
Get value:Hello7 for key:World7
Get value:Hello8 for key:World8
Get value:Hello9 for key:World9
//removeAllObjects输出
Remove Object Hello5
Remove Object Hello6
Remove Object Hello7
Remove Object Hello8
Remove Object Hello9
//最后一个for循环输出
Get value:(null) for key:World0
Get value:(null) for key:World1
Get value:(null) for key:World2
Get value:(null) for key:World3
Get value:(null) for key:World4
Get value:(null) for key:World5
Get value:(null) for key:World6
Get value:(null) for key:World7
Get value:(null) for key:World8
Get value:(null) for key:World9
//输出test字符串
Test Hello, World
```

## 网络数据缓存

有时对一个URL请求多次可能返回数据都一样, 这样会造成用户流量浪费, 程序响应速度不够快..这时需要缓存网络请求(内存缓存/硬盘缓存)

缓存步骤:

1. 请求服务器的数据
2. 将服务器的数据缓存到硬盘(沙盒中), 此时内存中有缓存, 硬盘(沙盒中)也有缓存

再次请求:

1. 如果程序没有被关闭, 一直运行, 此时内存缓存中有数据, 此时请求可以直接使用内存中数据
2. 如果内存缓存已经消失, 没有数据, 硬盘缓存依旧存在, 需要读取硬盘中的数据, 读取后内存中又有数据了

### 网络缓存数据的实现

##### 1. 说明

一般Get请求一般用来查询数据, 而Post请求一半是发送数据给服务器, 所以post变动性比较大, 因此一般只对get做缓存, 而不对post进行缓存.

iOS中, 可以使用NSURLCache类缓存数据

##### 2. NSURLCache

iOS中的缓存需要用到NSURLCache类, 缓存原理, 一个NSURLRequest对应一个NSCacheURLResponse

##### 3. NSURL常见的用法

1. 获得全局缓存对象(不需要手动创建) NSURLCache *cache = [NSURLCache sharedinstance];
2. 设置内存缓存的最大容量setMemoryCapacity:(NSUInteger)memoryCapacity;
3. 设置硬盘缓存的最大容量setDiskCapacity:(NSUInteger)diskCapacity;
4. 设置存储位置沙盒/library/caches
5. 取得某个请求的缓存:-(NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request;
6. 清除某个请求的缓存:- (void)removeCachedResponseForRequest:(NSURLRequest *)request;
7. 清除所有缓存:- (void)removeAllCachedResponses;



##### 4.  缓存Get请求

想要怼某个Get进行缓存

NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

request.cachePolicy = NSURLRequestCacheDataElseLoad;

只要设置了缓存策略, 系统会自动利用NSURLCache进行缓存

##### 5. iOS提供了7中缓存策略(实际上只能用4种)

NSURLRequestUseProtocolCachePolicy // 默认的缓存策略(取决于协议)

NSURLRequestReloadIgnoringLocalCacheData // 忽略缓存, 重新请求

NSURLRequestReturnCacheDataElseLoad //有缓存就用缓存, 没有换存就重新请求

NSURLRequestReturnCacheDataDontLoad // 有缓存就用缓存, 如果没有换存就不发送请求.

//下面三种无法实现

NSURLRequestReloadIgnoringLocalAndRemoteCacheData

NSURLRequesReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData //忽略缓存重新请求

NSURLRequestReloadRevaildatingCacheData // 未实现

##### 6. 缓存注意事项

1. 经常更新: 不使用缓存
2. 一成不变: 果断用缓存
3. 偶尔更新: 可以定期更改缓存策略或者清除缓存

# 2. 隐式动画和显式动画区别

隐式动画是iOS创建动画的基础, 直接设定UI可见元素的目标值, 即可自动生成平滑变化的过渡动画

显示动画是为了应付复杂的需求, 例如让视图沿曲线运动.显示动画不像隐式动画那样, 默认一个初始状态, 设置一个目标状态. 显示动画需要定义完整的动画流程,  要显示的定义动画对象, 设置动画对象的哥哥状态, 然后用动画对象应用到视图上, 虽然麻烦, 但是更灵活.

# 3. Block内部结构和原理

Block: 带自动变量的匿名函数.

#### Block实现原理

Block实际上是作为C语言源码来处理的, 使用LLVM编译器恩clang命令可以将含有Block的ObjC的代码转换成C++源码

```
clang -rewrite-objc 源码文件名
```

编译后可以得到三段主要代码,   _ _main_block_impl_0,    _ _main_block_func_0, __main_block_desc_0 

```
struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  int i;
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _i, int flags=0) : i(_i) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  int i = __cself->i; // bound by copy

  printf("hello world! %d\n",i);

 }

static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
int main(){
 int i = 10;

 void(*myBlock)(void) = (void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, i);

 ((void (*)(__block_impl *))((__block_impl *)myBlock)->FuncPtr)((__block_impl *)myBlock);

 return 0;
}
```

其中block_impl(实现)的结构体为可以看到一个block的结构体

```
struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
}
```

*isa指针说明block可以作为对象使用, 指针变量FuncPtr是指向了block代码的函数首地址

#### block如何截获自动变量

栈上的变量以参数形式传入到impl_0的构造函数中, 即为变量的自动截获, 栈上的数据无论发生什么变化都不会影响到Block以参数形式传入捕获的变量, 但这个变量是指向对象指针的话, 是可以修改这个对象的.

#### block分为全局block, 堆block, 栈block.

注意在栈上的block, 如果没有捕获自动变量的block仍在全局数据区, 而非栈上.设置在栈上的block, 如果作用域结束会被废弃, 对于超出block作用域仍要使用的可以通过copy将栈上block移到堆上.ARC时, 大多数情况下编译器会自动判断, 复制到堆上, 通常有以下几种情况

1. 调用copy
2. 将block作为函数返回值
3. 将block赋值给__strong修改的变量
4. 用Cocoa含有usingBlock的方法

#### 使用__block发生了什么

block捕获的自动变量加上__block, 就可以在block内部读写该变量, 也可以在栈上读写该变量.

原理: __block修饰符将自动变量封装成一个结构体, 让其在堆上创建, 以方便访问和修改的是同一份数据.

#### 循环引用

原因: 一个对象A有block类型的属性, 从而持有这个block, 如果block代码快中使用这个对象A,两者互相持有, 不能再作用域结束后正常释放.

解决: 对象A持有block, 但block不强引用持有对象A

# 4. tableView的高度预估价机制

estimateHeightForRowAtIndexPath, 这个方法用于返回一个cell的预估计高度, 如果在程序中实现了这个方法, tableView首次加载的时候不会调用heightForRowAtIndexPath, 而是用estimateHeightForRowAtIndexPath返回高度的预估计值, 然后tableView就可以显示出来, 等到cell可见的时候, 再调用heightForRowAtIndexPath获取正确的cell高度.

# 5. autorelease的原理和应用场景

#### autorelease的释放时机

autorelease并不是在作用域结束后释放, 而是在当前runloop迭代结束后才会释放的, 释放的原因是因为系统中每个runloop迭代中都加入了自动释放池push和pop.

##### AutoReleasePool实现原理

AutoReleasePool并没有自身的结构, 他是基于多个AutoReleasePoolPage(一个C++类)以及双链表组合起来的结构, 其基本操作都是封装了AutoReleasePool的方法, 可以push, pop, 自动释放池将用完的对象集中起来, 容易释放, 起到延迟释放对象的作用.

##### AutoRelease应用场景

当有大数for循环时, 短时间内创造大量对象, 早默认的自动释放池释放之前这些对象不会释放, 占用大量内存, 造成内存高峰以致内存不足.

此时在循环内部嵌套一个自动释放池.

# 6. KVO和KVC

##### 概念

KVC: 就是键值编码, 实在NSKeyValueCoding非正式协议下使用字符串间接访问对象属性的机制,  是传统访问方法的一种替代, 可以强行访问私有属性.

KeyPath: 键路径就是键值编码中的属性的key, 由连续字符串组成, 键名之间用点隔开.

KVO: 键值编码的观察者模式实现

##### 使用场景

KVC的应用场景

KVC允许开发者通过key间接地访问对象属性, 而不需要调用类的存取方法, 这样可以动态的访问修改属性.

1. 动态的存取值
2. 利用KVC来访问对象的私有变量和属性
3. 利用KVC进行Model和Dictionary之间的转换
4. 利用KVC实现高阶信息传递

```
NSArray *test = @[@"jack", @"sam", @"tom"];
NSArray *result = [test valueForKey:@"capitializedString"];
```

##### KVO原理

当某个对象被第一次观察时, 系统就回在运行时动态的创建一个类的派生类, 这个类会重写父类中的setter和getter方法, 向setter中添加通知机制, 在setter的值改变前添加willChangeValueForkey, 改变后添加didChangeValueForKey, 分别用于属性即将发生变化和已经发生变化.使用KVO必须遵循kvc或者setter来改变值, 否则无法实现kvo.

派生类还重写class方法来欺骗开发者, 让开发者以为调用的是原始类, 然后系统会将这个类的isa指针指向新创建的类.开发者调用setter实际上是调用派生类的setter, 从而实现通知机制.

# 7. tableView优化方法

主要从两方面入手

1. 减少cellForRowAtIndexPath代理中的计算量(cell的内容计算)
2. 减少heightForRowAtIndexPath代理中的计算量(cell的高度计算)

减少cellForRowAtIndexPath计算

1. 提前计算好cell中的一些基本数据, 代理调用时直接取出
2. 图片要异步加载
3. 图片数量多时, 图片的尺寸经过transform矩阵变换压缩好, 准备预览图
4. 图片懒加载, 当滚动速度很快时, 避免请求服务器频繁
5. 尽量手动Drawing视图提升流畅性, 而不是直接子类化, UITableViewCell, 然后覆盖drawRect方法, 因为cell中不是只有一个contentView, 绘制cell不建议采用UIView, 而是使用CALayer.

减少heightForRowAtIndexPath计算

1. 使用estimateHeightForRowAtIndexPath
2. 设置heightForRow为固定高
3. 如果高度不固定, 尽量将cell的高度数据计算好存储起来,代理调用时, 直接取.

图形渲染

1. 减少autolayout在cell中的使用, 尽量使用frame
2. 减少圆角的使用, 让 UI直接裁好
3. 使用Texture(ASDisplay)facebook的库, 此库将所有UI的耗时操作移出主线程, 从而提高了帧数.

# 8. 自旋锁和互斥锁(同步锁)的区别

互斥锁(Mutex)属于sleep-waiting类型的锁, 例如一个临界资源被两个线程A, B所使用, B正在使用资源时, A则阻塞

自旋锁(Spin Lock)是busy-waiting类型的, 临界资源被B使用时, A会不停的请求这个这个锁, 直到获得这个锁.

# 9. 多线程GCD和NSOperation的比较

##### NSOperation

1. OC语言API
2. 面向对象, 可以封装复用
3. 控制精细灵活
4. 用于复杂项目

##### GCD

1. C语言API
2. 简单易读,代码精简
3. 控制简单粗略
4. 用于简单项目

NSOperation可以实现中途取消, 而在gcd中无法取消

GCD的最大有点是简单易用, 多数函数是线程安全的, 对于不复杂的多线程操作会节省大量代码

# 10. NSCopying协议

浅拷贝: 指针拷贝

深拷贝: 内容拷贝 生成新对象

总结:

1. 深拷贝会产生新对象, 浅拷贝不会
2. 不可变对象的copy才是浅拷贝, 其他情况都是深拷贝
3. 若想类具备拷贝功能, 必须要遵守NSCopy协议, 并重写copyWithZone方法
4. 一般情况下使用浅拷贝, 深拷贝会使内存中有两个一模一样的对象, 会造成浪费
5. NSString一般会使用copy策略.

让对象具有拷贝能力, 实现NSCopying协议, 该协议只有一个方法copyWithZone

```
- (id)copyWithZone:(NSZone *)zone {
    Person *copy = [[[self class] allocWithZone:zone] init];
    copy.firstname = _firstName;
    copy.lastName = _lastName;
    // 如果改成洗面为深拷贝
    copy.firstName = [_firstName copy];
    copy.lastName = [_lastName mutableCopy];
    return copy;
}
```

# 11. pushViewController后view的释放时机

1. loadView
2. loadViewIfNeed
3. viewDidLoad
4. viewWillAppear
5. viewDidAppear
6. viewWillDisappear
7. viewDidDisappear
8. – (void)didRecevieMemoryWarning
9. – (void)viewWillUnload iOS6后废弃
10. -(void)viewDidUnload
11. [UIViewController dealloc]

# 12. weak的应用场景, 和assign的区别, weak的实现原理

Weak: 一般用来修饰OC对象, weak修饰的对象引用计数不会加1, 对象被释放后会自动置为nil, 避免了引起野指针访问引起的崩溃, weak也可以用来解决循环引用

Assign: 用来修饰基本数据类型, 也可以用来修饰OC对象, 但是assign的指针是强指针, 这个指针被释放后, 仍指向这块内存, 必须手动置为nil, 否则会产生野指针. 

##### Weak原理

weak其实是一个哈希表, key是所指向对象的指针, vlue是weak指针的地址数组(value是数组的原因, 因为一个对象可能被多个弱引用指针指向)

weak原理实现过程分三个步骤

1. 初始化开始时, 会调用objc_initWeak函数, 初始化新的weak指针指向对象的地址
2. 调用objc_storeWeak()函数, objc_storeWeak()函数的作用是用来更新指针的指向, 创建弱引用表
3. 最后会调用clearDeallocating函数, 而clearDeallocating函数首先根据对象的地址获取weak指针的地址数组, 然后遍历这个数组, 将其中的数组置为nil, 把这个entry从weak表中函数, 最后一步清理对象的记录

# 13. SDWebImage中的缓存机制是如何实现的

与缓存有关的共两个类SDImageCacheConfig和SDImageCache

```
@interface SDImageCacheConfig : NSObject

//是否压缩图片，默认为YES，压缩图片可以提高性能，但是会消耗内存
@property (assign, nonatomic) BOOL shouldDecompressImages;

//是否关闭iCloud备份，默认为YES
@property (assign, nonatomic) BOOL shouldDisableiCloud;

//是否使用内存做缓存，默认为YES
@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;

/** 缓存图片的最长时间，单位是秒，默认是缓存一周
 * 这个缓存图片最长时间是使用磁盘缓存才有意义
 * 使用内存缓存在前文中讲解的几种情况下会自动删除缓存对象
 * 超过最长时间后，会将磁盘中存储的图片自动删除
 */
@property (assign, nonatomic) NSInteger maxCacheAge;

//缓存占用最大的空间，单位是字节
@property (assign, nonatomic) NSUInteger maxCacheSize;
@end
```

SDImageCache文件

```
//获取图片的方式类别枚举
typedef NS_ENUM(NSInteger, SDImageCacheType) {
    //不是从缓存中拿到的，从网上下载的
    SDImageCacheTypeNone,
    //从磁盘中获取的
    SDImageCacheTypeDisk,
    //从内存中获取的
    SDImageCacheTypeMemory
};

typedef NS_OPTIONS(NSUInteger, SDImageCacheOptions) {
    /**
     * By default, we do not query disk data when the image is cached in memory. This mask can force to query disk data at the same time.
     */
    SDImageCacheQueryDataWhenInMemory = 1 << 0,
    /**
     * By default, we query the memory cache synchronously, disk cache asynchronously. This mask can force to query disk cache synchronously.
     */
    SDImageCacheQueryDiskSync = 1 << 1,
    /**
     * By default, images are decoded respecting their original size. On iOS, this flag will scale down the
     * images to a size compatible with the constrained memory of devices.
     */
    SDImageCacheScaleDownLargeImages = 1 << 2
};

//查找缓存完成后的回调块
typedef void(^SDCacheQueryCompletedBlock)(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType);
//在缓存中根据指定key查找图片的回调块
typedef void(^SDWebImageCheckCacheCompletionBlock)(BOOL isInCache);
//计算磁盘缓存图片个数和占用内存大小的回调块
typedef void(^SDWebImageCalculateSizeBlock)(NSUInteger fileCount, NSUInteger totalSize
```

SDImageCache

pragma mark - Properties

```
/*
SDWebImage真正执行缓存的类
SDImageCache支持内存缓存，默认也可以进行磁盘存储，也可以选择不进行磁盘存储
*/
@interface SDImageCache : NSObject

#pragma mark - Properties

//SDImageCacheConfig对象，缓存策略的配置
@property (nonatomic, nonnull, readonly) SDImageCacheConfig *config;

//内存缓存的最大cost，以像素为单位，后面有具体计算方法
@property (assign, nonatomic) NSUInteger maxMemoryCost;

//内存缓存，缓存对象的最大个数
@property (assign, nonatomic) NSUInteger maxMemoryCountLimit;
```

`maxMemoryCost`其实就是`NSCache`的`totalCostLimit`，这里它使用像素为单位进行计算，`maxMemoryCountLimit`其实就是`NSCache`的`countLimit`，需要注意的是`SDImageCache`继承自`NSObject`没有继承`NSCache`，所以它需要保存这些属性

pragma mark - Singleton and initialization

```
//单例方法用来获取一个SDImageCache对象
+ (nonnull instancetype)sharedImageCache;

/*
初始化方法，根据指定的namespace创建一个SDImageCache类的对象
这个namespace默认值是default
主要用于磁盘缓存时创建文件夹时作为其名称使用
*/
- (nonnull instancetype)initWithNamespace:(nonnull NSString *)ns;

//初始化方法，根据指定namespace以及磁盘缓存的文件夹路径来创建一个SDImageCache的对象
- (nonnull instancetype)initWithNamespace:(nonnull NSString *)ns
                       diskCacheDirectory:(nonnull NSString *)directory NS_DESIGNATED_INITIALIZER;
```

上面几个方法就是其初始化方法，提供了类方法用于获取一个单例对象，使用单例对象就会使用所有的默认配置，下面两个初始化构造函数提供了两个接口但真正进行初始化的是最后一个

pragma mark - Cache paths

```
//根据fullNamespace构造一个磁盘缓存的文件夹路径
- (nullable NSString *)makeDiskCachePath:(nonnull NSString*)fullNamespace;

/*
添加一个只读的缓存路径，以后在查找磁盘缓存时也会从这个路径中查找
主要用于查找提前添加的图片
*/
- (void)addReadOnlyCachePath:(nonnull NSString *)path;
```

上面两个方法主要用于构造磁盘缓存的文件夹路径以及添加一个指定路径到缓存中，以后搜索缓存时也会从这个路径中查找，这样设计就提供了可扩展性，如果以后需要修改缓存路径，只需把之前的路径添加进来即可

pragma mark - Store Ops

```
/*
根据给定的key异步存储图片
image 要存储的图片
key 一张图片的唯一ID，一般使用图片的URL
completionBlock 完成异步存储后的回调块
该方法并不执行任何实际的操作，而是直接调用下面的下面的那个方法
*/
- (void)storeImage:(nullable UIImage *)image
            forKey:(nullable NSString *)key
        completion:(nullable SDWebImageNoParamsBlock)completionBlock;

/*
同上，该方法并不是真正的执行者，而是需要调用下面的那个方法
根据给定的key异步存储图片
image 要存储的图片
key 唯一ID，一般使用URL
toDisk 是否缓存到磁盘中
completionBlock 缓存完成后的回调块
*/
- (void)storeImage:(nullable UIImage *)image
            forKey:(nullable NSString *)key
            toDisk:(BOOL)toDisk
        completion:(nullable SDWebImageNoParamsBlock)completionBlock;

/*
根据给定的key异步存储图片，真正的缓存执行者
image 要存储的图片
imageData 要存储的图片的二进制数据即NSData数据
key 唯一ID，一般使用URL
toDisk 是否缓存到磁盘中
completionBlock
*/
- (void)storeImage:(nullable UIImage *)image
         imageData:(nullable NSData *)imageData
            forKey:(nullable NSString *)key
            toDisk:(BOOL)toDisk
        completion:(nullable SDWebImageNoParamsBlock)completionBlock;
        
/*
根据指定key同步存储NSData类型的图片的数据到磁盘中
这是一个同步的方法，需要放在指定的ioQueue中执行，指定的ioQueue在下面会讲
imageData 图片的二进制数据即NSData类型的对象
key 图片的唯一ID，一般使用URL
*/
- (void)storeImageDataToDisk:(nullable NSData *)imageData forKey:(nullable NSString *)key;
```

pragma mark - Query and Retrieve Ops

```
/*
异步方式根据指定的key查询磁盘中是否缓存了这个图片
key 图片的唯一ID，一般使用URL
completionBlock 查询完成后的回调块，这个回调块默认会在主线程中执行
*/
- (void)diskImageExistsWithKey:(nullable NSString *)key completion:(nullable SDWebImageCheckCacheCompletionBlock)completionBlock;

/**
 * Operation that queries the cache asynchronously and call the completion when done.
 *
 * @param key       The unique key used to store the wanted image
 * @param doneBlock The completion block. Will not get called if the operation is cancelled
 *
 * @return a NSOperation instance containing the cache op
 */
- (nullable NSOperation *)queryCacheOperationForKey:(nullable NSString *)key done:(nullable SDCacheQueryCompletedBlock)doneBlock;

/*
同步查询内存缓存中是否有ID为key的图片
key 图片的唯一ID，一般使用URL
*/
- (nullable UIImage *)imageFromMemoryCacheForKey:(nullable NSString *)key;

/*
同步查询磁盘缓存中是否有ID为key的图片
key 图片的唯一ID，一般使用URL
*/
- (nullable UIImage *)imageFromDiskCacheForKey:(nullable NSString *)key;

/*
同步查询内存缓存和磁盘缓存中是否有ID为key的图片
key 图片的唯一ID，一般使用URL
*/
- (nullable UIImage *)imageFromCacheForKey:(nullable NSString *)key
```
pragma mark - Remove Ops

```
/*
根据给定key异步方式删除缓存
key 图片的唯一ID，一般使用URL
completion 操作完成后的回调块
*/
- (void)removeImageForKey:(nullable NSString *)key withCompletion:(nullable SDWebImageNoParamsBlock)completion;

/*
根据给定key异步方式删除内存中的缓存
key 图片的唯一ID，一般使用URL
fromDisk 是否删除磁盘中的缓存，如果为YES那也会删除磁盘中的缓存
completion 操作完成后的回调块
*/
- (void)removeImageForKey:(nullable NSString *)key fromDisk:(BOOL)fromDisk withCompletion:(nullable SDWebImageNoParamsBlock)completion;

#pragma mark - Cache clean Ops

//删除所有的内存缓存，即NSCache中的removeAllObjects
- (void)clearMemory;

/*
异步方式清空磁盘中的所有缓存
completion 删除完成后的回调块
*/
- (void)clearDiskOnCompletion:(nullable SDWebImageNoParamsBlock)completion;

/*
异步删除磁盘缓存中所有超过缓存最大时间的图片，即前面属性中的maxCacheAge
completionBlock 删除完成后的回调块
*/
- (void)deleteOldFilesWithCompletionBlock:(nullable SDWebImageNoParamsBlock)completionBlock;
```

上面几个方法是用来删除缓存中图片的方法，以及清空内存缓存的方法

pragma mark - Cache Info

```
//获取磁盘缓存占用的存储空间大小，单位是字节
- (NSUInteger)getSize;

//获取磁盘缓存了多少张图片
- (NSUInteger)getDiskCount;

/*
异步方式计算磁盘缓存占用的存储空间大小，单位是字节
completionBlock 计算完成后的回调块
*/
- (void)calculateSizeWithCompletionBlock:(nullable SDWebImageCalculateSizeBlock)completionBlock;
```

pragma mark - Cache Paths

```
/*
根据图片的key以及一个存储文件夹路径，构造一个在本地的图片的路径
key 图片的唯一ID，一般使用URL
inPath 本地存储图片的文件夹的路径
比如:图片URL是http:www.baidu.com/test.png inPath是/usr/local/，那么图片存储到本地后的路径为:/usr/local/test.png
*/
- (nullable NSString *)cachePathForKey:(nullable NSString *)key inPath:(nonnull NSString *)path;

/*
根据图片的key获取一个默认的缓存在本地的路径
key 图片的唯一ID，一般使用URL
*/
- (nullable NSString *)defaultCachePathForKey:(nullable NSString *)key;
@end
```

