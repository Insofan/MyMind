# 1. ObjC中的属性和实例变量区别

1. #### 传统Cpp类实例变量的定义形式

变量名用public, private, protected, package等修饰词, 默认是.m private, .h protected

这个形势缺点:

1. 每个变量都需要手动编写setter和getter当变量多时, 会让代码冗余
2. 这种类实例变量定义属于"硬编码", 即对象内部的变量定义和布局已经在编译器写死, 编译后不可更改, 否则会出错. 他是通过地址偏移量来访问, 如果在类中插入新的变量., 那么必须要重新编译每个变量的偏移量, 否则会报错.

#### 2. 属性变量封装

编译器会自动合成属性的存取, 通过存取方法就可以根据变量名用点语法去访问

synthesize 自定义变量名

dynamic 自定义存取方法

# 2. UIView和CALayer的区别, 还用过那些layer

1. UIView和CALayer是什么

UIView简单来说是一个可以渲染可见内容的矩形框, 里面的内容可以和用户交互, UIView可以对交互事件进行处理, 除了其背后CALayer的图形操作支持, 自身也有例如颜色等最基本属性

CALayer是动画中最常用的类, 包含在QuartzCore框架中, 和UIView类似, 但是不能处理交互, 他是一个比UIView更底层的图形类, 是对底层(opengl es)的封装, 用于复杂显示.

2. 区别

CALayer无法响应交互, CALayer继承自QuartzCore, UIView继承自UIResponder, 

分工不同, UIView类侧重怼显示内容的整体管理布局, 而CALayer侧重内容的显示绘制, 动画, 所属框架不同

3. 为什么UIView和CALayer是两个平行的层级结构

平行结构, 做到职责分离, 实现绘制显示, 和布局解耦, 在iOS上是UIKit UIView, mac os 上是AppKit, NSView, 其中鼠标和手机交互明显有不同, 创建两个层次能在iOS和MacOS 之间共享代码

4. UIWindow是什么, 有什么特点和作用

UIWindow提供一个显示区域用来显示UIVIew, UIWindow是UIView的子类, 并且一般一个应用也只有一个UIWindow

# 3. Category为什么不能扩展属性

```objective-c
//line 1784
struct objc_category {
    char * _Nonnull category_name                            OBJC2_UNAVAILABLE;
    char * _Nonnull class_name                               OBJC2_UNAVAILABLE;
    struct objc_method_list * _Nullable instance_methods     OBJC2_UNAVAILABLE;
    struct objc_method_list * _Nullable class_methods        OBJC2_UNAVAILABLE;
    struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE;
}
```

里面就没有属性, 需要用getassociate, setassociate.