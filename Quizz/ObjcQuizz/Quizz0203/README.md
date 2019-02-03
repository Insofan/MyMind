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

