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