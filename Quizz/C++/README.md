## Q: 预处理做了什么工作

![](https://upload-images.jianshu.io/upload_images/4254263-4c7392949a83933b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/790/format/webp)

所有以#开头的代码都属于预处理器处理的范畴

1. #include: 将头文件的内容包含到源文件中
2. #define: 将宏定义进行宏展开
3. #ifdef: 条件编译展开(#ifdef, #ifndef, #if, #else, #elif, #endif)
4. #other: 处理其它宏指令(包括#error, #warning, #line, #pragma)

实际上除了处理#开头的代码行以外, 还做了一些其他工作, 只是提到预处理时, 习惯性的把它的功能与处理#开头的代码划上等号.

1. 处理预定义的宏, 例如 _ _ DATE_ _  , _ _ FILE _ _(这种宏都是以双下划线开始, 并结束, 自己写宏的时候应该避免冲突)
2. 处理注释
3. 处理三元符??=替换成#, ??/替换成\ (这种是因为在最早的C语言中, 键盘输入不全, 有些键盘无法输入#等, 现在则没有)

## Q: 简述#include<> 和#include ""的区别

这两种都可以将指定文件中的内容引入到当前文件, 但采用了不同的搜索策略, #include<>搜索时直接从编译器指定的路径进行搜索, 如果找不到引入文件, 程序直接报错, 因此系统提供的头文件推荐使用#include<>. #include""首先从程序所在的目录进行搜索, 如果失败再从编译器指定位置进行搜索, 如果搜索失败报错. 虽然系统提供的文件也可以用#include""进行搜索导入, 但会进行无畏的搜索

## Q: 简述#与##在define中的作用

1. #在宏定义中是将后面的参数转换成字符串, 仔细观察下面两个宏的调用

```c++
#include <iostream>
using namespace std;
#define PRINTCUBE(x) cout<< "cube(" << #x <<") =" << (x) * (x) * (x) << endl;
int main() {
    int y = 5;
    PRINTCUBE(5);
    PRINTCUBE(y);
    return 0;
}
输出:
cube(5) =125
cube(y) =125
```

第一个PRINTCUBE中的5, cube中是将 5这个数字字符串化输出, 第二个是直接字符串化y.

2. ##在宏定义中是将前后的参数进行字符串连接, 而且不依赖于参数的具体类型

```c++
#define LINK3(x, y, z) x##y##z
int main() {经过预处理, 编译, 汇编, 链接等多个步骤, 才能生成可以再机器上直接运行的可执行程序.

￼


    cout <<LINK3(3, 5, 0)<< endl;
    return 0;
}
输出:
350
```

## Q: 简述assert断言的概念

实际上assert是一个宏, 并非一个函数, 在assert.h里定义这个宏, 检测条件表达式为假时, 检测失败. 在调试结束后应该在#include assert.h之前插入#define NDEBUG禁用assert宏.

注意事项每个assert中只检测一个条件, 另外不要再assert中修改变量的值(因为assert指在debug版本中起作用, release版本中assert内部对变量修改也随之失效, 会造成不同版本取值不同).

## Q: 简述extern, static, const三种变量的区别

全局变量是指在函数外部定义的变量

1. extern: 如果将全局变量声明在头文件中, 并使用extern关键字修饰, 起作用是将变量导出, 表示在任何通过#include包含该头文件的文件中可以使用这个全局变量
2. static: 静态变量, 如果修饰在局部称为静态局部变量, 如果修饰在全局称为静态全局变量. 静态局部变量:  局部静态变量在程序首次执行该变量处时初始化, 再次执行到该变量不会初始化, 而是保留最新值, 因此静态全局变量作用域是函数内部, 但周期是整个程序的生命周期. 静态全局变量: 使用static修饰的全局变量, 兼具静态变量和全局变量的特性.
3. const: 修饰位常量型变量, 常量变量初始化之后不可以修改. 

##  Q: 简述i++和++i的区别, 并计算一段代码的值

##  ￼

```c++
//计算下列代码执行后i, j, m, n的值
int i = 10, j = 10;
int m = (i++) + (i++) + (i++);
int n = (++j) + (++j) + (++j);
```

i++是先赋值后加1, ++j是先加1再赋值

对于表达式m是先执行加法操作, 再执行i的自增运算.

对于表达是n是先执行所有的自增, 再执行加法操作

重点来了!

这种赋值语句依赖编译器的实现

gcc编译器中, 只要有两个完整的操作数, 就会立即执行加法运算, 所以++j在执行两次后已经具备了两个操作数, 此时j的值为12, 和第三次++j的13执行加法运算, 最终的结果是37, j的值是13

结果

```c++
vs2005下: i = 13 j = 13 m = 30 n = 39
gcc下: i = 13 j = 13 m = 30 n = 37
```

## Q: 简述静态全局变量的概念

在全局变量前加上static关键字, 并且不能用extern导出, 静态全局变量的作用域仅限于定义静态全局变量的文件内部.经过预处理, 编译, 汇编, 链接等多个步骤, 才能生成可以再机器上直接运行的可执行程序.

￼

## Q: 不使用break的switch语句

| 考评结果 |            年终奖品             |
| :------: | :-----------------------------: |
|    A     | 一个月奖金, 福利1, 福利2, 福利3 |
|    B     |    一个月奖金, 福利1, 福利2     |
|    C     |        一个月奖金, 福利1        |
|    D     |           一个月奖金            |

```C++
string helper(char mark) {
    string msg = "Your year award: ";
    switch (mark) {
        case 'A': msg.append("福利3");
        case 'B': msg.append("福利2");
        case 'C': msg.append("福利1");
        default: msg.append("一个月奖金");
    }
    return msg;
}
```

## Q: for循环的三要素, 并写出下面的输出循环

for 第一个分号初始化, 只执行一次, 第二个分号用来限制循环条件, 第三个分号用来更新与循环有关的变量.

```c++
bool foo(char c) {
    cout << c;
    return true;
}

int main() {
    int i = 0;
    for (foo('A'); foo('B') && (i++ < 2); foo('C')) {
        foo('D');
    }
    
    return 0;
}

#输出
A, B, C, D, B, C, D, B
```

## Q: 简述宏定义和内联函数

简单替换宏, 进行宏展开

```c++
#define ERROR_MESSAGE - 100
#define FILE_PATH D:\\study\\C++\\ch1\\test.txt
#define SECONDS_PER_DAY 60 * 60 24
```

带参数的宏:有的书上称为宏函数, 但宏函数并不是函数, 他只是用起来像宏函数, 和替换宏一样都是在预处理阶段进行代码替换, 但省去了函数调用过程.

```c++
#define OUTPUTINT(x) cout << "INT: " << x << endl;
#define OUTPUTCHAR(x) cout << "CHAR: " << x << endl;
```



宏函数本身有缺陷, 有些情况下会发生宏函数错误, 就出现了内联函数

```c++
class Rectangle {
public:
	Rectangle(int, int);
    int getSquare();
    int getGrith() { return 2 * (length + width);}
private:
    int length;
    int width;
    Rectangle::Rectangle(int l, int w): length(l), width(w){}
    inline int Rectangle::getSquare() {
        return length * width;
    }
}
```

Rectangle类将getSquare函数通过inline关键字定义为内联函数. 在编译阶段, 编译器在发现inline关键字时会将函数体保存在函数名所在的附表内, 在程序中调用内联函数的地方, 编译器直接在符号表中获取函数名和函数体, 并用内联函数替换掉函数调用, 从而节省函数调用的开销. 

注意: 在函数声明使用inline是无效的, 要在函数定义时使用, 函数使用者不需要知道该函数是否为内联函数.

## Q: 简述内联函数和宏定义的区别及使用时注意事项

内联可以实现宏定义很多无法实现功能, 而且可以完全覆盖宏

相同点:

- 目的相同: 都能节省函数频繁调用产生的时间空间的开销, 提高函数调用效率

- 实现类似: 宏定义和内联函数都是讲函数调用替换成完整的函数体

差异:

- 宏定义仅仅是字符串替换, 而内联函数是函数
- 宏定义的展开是在与编译器阶段, 而内联函数的展开是在编译阶段. 因此很多编译器的工作只对内联函数有效, 例如类型安全检查和自动类型的替换
- 内联函数作为类的成员可以访问类的所有成员, 包括公有成员, 保护成员, 私有成员, 而this指针也会被隐式正确使用, 而宏定义无法实现这些功能.

内联函数使用注意事项:

- 避免代码膨胀
- 内联函数定义要尽量简单
- 函数体过大且调用非常频繁的函数不适合做内联函数
- 内联函数要在函数定义时使用, 而不是函数声明时使用

但实际上: 编译器非常聪明, 如果这个函数过大, 内联函数并不会起作用, 编译器会将其视为函数, 所以inline是对编译器的一个建议, 将其设为内联函数, 而不是强制将其设置为内联函数, 类似clang中优化指针, 让两个相同值的NSString *指针指向同一地址, 他们应该指向不同地址

## Q: 宏定义的宏展开错误

指出下面程序中宏定义的错误并修改

```c++
#define MAX(a, b) a > b ? a : b
#define MUL(a, b) a * b

int main() {
    int x = 5, y = 0;
    int max = MAX(x, y);
    int product = MUL(x, y);
    cout << "The max is " << max << endl;
    cout << ""
    return 0;
}
```

答案

```c++
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MUL(a, b) ((a) * (b))
```

## Q: 简述下sizeof

- C语言中, 可以用sizeof运算符获取操作数所占内存空间的字节数
- sizeof是一个单目运算符(类似非 ! ), 并不是一个函数
- sizeof的操作数可以是类型名, 也可以是表达式, 例:int a = 1; sizeof(int); sizeof(a);, 如果是类型名直接计算, 如果是表达式先计算表达式的类型, 在确定所占字节数, 并不对表达式实际进行运算

应用场景

1. 分配内存: int *ptr = (int)malloc(sizeof(int) * 20);
2. 计算数组中元素个数, sizeof(dArr) / sizeof(double);

区分sizeof和strlen

一定不要使用sizeof来计算字符串的长度, 因为其中有结束符\0, sizeof 无法计算结构体成员的大小, 但是可以计算结构体大小

## Q: 什么是数据对齐

数据对齐是指在处理结构体成员时, 成员在内存中的起始地址编码必须是成员类型所占字符的整数倍.

例如: int类型的变量占用4个字节, 因此结构体中int类型成员的起始地址必须是4的整数倍, double类型成员的起始地址必须是8的整数倍.

由于结构体中的成员在内存中需要数据对齐, 就会造成结构体重逻辑上相邻成员的地址在物理上并不相邻, 两个成员之间会有多余出来的空间, 有些书上称之为补齐

## Q: 给出下面两个结构体sizeof计算结果

```c++
struct s1 {
  	char a;
    short b;
    int c;
    double d;
};

struct s2 {
  	int a;
    double b;
    short c;
    char d;
};
```

s1的第一个成员为char, 起始地址为0, 占一个字节, 下一个地址为1, 第二个成员为short, 占两个字节, 起始字节必须为2的整数倍, 所以1就空出来了, 从2开始, 下一个字节为4, 第三个成员为int类型, 占用4个字节, 当前地址恰好为4, 是4的倍数, 下一个地址为8, 下一个成员为double, 占用字节8 , 起始地址恰好为8, 下一个字节地址为16, 整个结构体占用了0-15 16个字节单元, 但还有一条原则, 结构体sizeof的计算必须是结构体中占用空间最多成员的整数倍, 其中占用最多为double所以结构体占用了16, sizeof结果为16

s2只是打乱了成员顺序, 但是结果完全不同

s2的第一个成员a为int类型, 起始地址为0, 占用4个字节, 下一个字节为4, 但下一个成员是double类型占用8个字节, 起始地址必须是8的倍数所以从8开始, 则4到7空出, 下一个字节为16, c为short占用两个字节, 下一个字节为18 , char占用一个字节下一个字节为19, 所以结构体一共占用18个字节, 但是按照sizeof原则, 必须为最大成员所占字节的整数倍, 即8的整数倍, 所以结果为24

## Q: 写出下面结构体的sizeof计算结果

```c++
struct s1 {
    int a;
};
struct s2 {
    char a[4];
};
struct s3 {
    char a[4];
    char b;
};
struct s4 {
    s1 a;
    char b;
};
struct s5 {
    s2 a;
    char b;
};
```

对于结构体嵌套问题, 如果结构体成员包括数组或其他结构体, 在数据对齐时, 要以结构体中最深层次的基本数据结构类型为准

1. s1: 4
2. s2: 4
3. s3: 5
4. s4: 8: 是s1的int加char 加补齐3个字节
5. s5:  5 s2包含一个char数组, char是1 所以是1整数倍即可 

## Q: 简述内存分配方法

1. 在C语言中使用malloc()和free()函数分配和释放内存空间
2. 在C++中用new和delete来分配和释放内存空间

## Q: 简述new, delete和malloc, free的区别

- malloc和free的操作只适用于基本数据类型, new和delete运算符即可以用于基本数据类型, 又可以用于自定义类型, 其申请和释放的内存都在堆上
- 对于基本类型, new操作符首先分配空间, 然后用括号内的值初始化堆上的数据, 并返回空间的首地址, delete操作符直接释放堆上的空间. 对于自定义类型, new操作符首先分配空间, 然后根据括号内的参数调用类的构造函数初始化对象, delete操作符先调用类的析构函数, 再释放对象在堆上的空间, 所以new函数不但申请了空间, 还完成了类的初始化, delete操作符不但释放了空间, 还调用了类的析构函数.
- malloc和free是函数, 而new和delete是操作符

## Q: 堆空间与栈空间

- 用malloc或new动态分配的空间来自堆空间, 指针指向一个堆空间的地址, 而指针本身作为局部变量存储在栈空间, 栈由系统分配, 堆一般由程序员分配

## Q: 内存泄漏

- 通过malloc动态分配的内存空间必须通过free函数来释放, 这两个函数成对出现, 如果申请的空间没有释放, 就会发生内存泄漏, 系统不会主动释放通过malloc在堆上申请的空间, 这样内存会被慢慢耗尽
- 在通过free函数释放空间后, 最好将指针立即置空, 这样可以防止后面的程序对指针进行误操作

## Q: 不使用临时变量交换两个数

```c++
a = a^b;
b = a^b;
a = a^b;
```

## Q: 简述main函数

main函数在执行之前经过一系列初始化工作, 在main函数执行之后也有一系列扫尾工作.
标准main函数有两种, 一种不带参, 一种带参
```c++
int main()
int main(int argc, char *argv[])
```
第一个参数argc: argument count 缩写, 参数个数缩写
第二个参数argv: argument value 缩写, 参数具体值, 其中argv[0]是程序的名字, 其余是命令行输入参数.

## Q: 简述main函数在执行前后都发生了什么
先进行初始化工作, 例如初始化静态变量, 全局变量.然后开始进入main函数, 在main结束后会进行扫尾工作,并不会立即结束, 例如调用atexit注册函数, 顺序与atexit顺序正好相反.

```c++
void func1() {
    cout << "func 1" << endl;
}
void func2() {
    cout << "func 2" << endl;
}
void func2() {
    cout << "func 3" << endl;
}
int main() {
    atexit(func1);
    atexit(func2);
    atexit(func3);
    cout << "main " << endl;
	return 0;
}
输出顺序是 main > func3 > func2 > func1
```
## Q: 简述指针的概念
内存中每个字节都有唯一的编码, 称为内存地址. 驻留在内存中的变量页有一个地址与之对应, 确定变量在内存中的起始位置.
指针保存的是变量的地址, 指针可以找到变量在内存中的位置
## Q: 指针与数组的区别
程序中定义了8个变量, 请指出哪些是指针, 哪些是数组? 并写出程序的输出

```c++
void equal(char str7[], char str8[]) {
    printf("%d\n", str7 == str8);
}

int main() {
    char str1[15] = "hello,world";
    char str2[15] = "hello,world";
    char str3[] = "hello, world";
    char str4[] = "hello, world";
    
    char *str5 = "hello,world";
    char *str6 = "hello,world";
    
    printf("%d\n", str1 == str2);
    printf("%d\n", str3 == str4);
    printf("%d\n", str5 == str6);
    
    equal(str1, str2);
    getchar();
    
    return 0;
}

输出:
1. str1, str2 是两个字符数组, 数组存储在栈上, 两个数组有各自独立的存储空间, 内存地址没有交集, 所以是0
2. str3, str4 与上面同理, 输出是0
3. str5, str6是两个典型的指针, 定义类指针类型和名称, 两个指针都指向字符串常量"hello, world"的首字符, 字符串常量保存在字符串常量区中, 内容相同的字符串常量区中只有一份拷贝, str5, str6指向同一个常量, 所以输出1
4. str7, str8 看起来是数组, 但是作为参数是加上是指针, 是str1, str2的指针所以输出为0
```





























