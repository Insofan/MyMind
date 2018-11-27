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

## Q:  指针常量和常量指针

指针常量本质上是一个常量, 指针用来说明常量的类型, 表示该常量是一个指针类型的常量, 指针自身的值不可改变, 始终指向同一个地址, 但可以改变指针地址中的内容

```c++
  int a = 10, b = 20;

    int * const p = &a;
    cout << a << endl;
    cout << p << endl;
    *p = 30;
    cout << a << endl;
    cout << p << endl;

输出:
10
0x7ffdbeb56998
30
0x7ffdbeb56998

```



常量指针, 本质上是一个指针, 指针指向一个''常量'', 指针指向的内容是不可改变的, 指针看起来好像指向了一个常量. 

```c++
 //常量指针, 不允许修改内容
    int c = 10, d = 20;
    const int *q = &c;
    cout << c << endl;
    cout << q << endl;
    q = &d;
    cout << c << endl;
    cout << q << endl;
```

## Q: 指针常量和常量指针的常见错误

```c++
    int m = 10;
    const int n = 20;

    const int *ptr1 = &m;
    int * const ptr2 = &m;

    ptr1 = &n; //right
    ptr2 = &n; // err

    *ptr1 = 3; // err
    *ptr2 = 4; // right

    int *ptr3 = &n; //err
    const int *ptr4 = &n; //right

    int *const ptr5; //err
    ptr5 = &m; /err

    const int *const ptr6 = &m;
    *ptr6 = 5; //err
    ptr6 = &n; //err
//////////////////////
其中 const int n 和 int * const ptr2 都是常量, 所以必须要在定义的时候初始化
常量指针const int *ptr1 可以指向变量, 但无法通过ptr1修改m的值

ptr1是常量指针, 可以修改指针的值, 不能修改指针指向的内容, 也就是ptr1可以修改, 而 *ptr1 不能修改
ptr2是指针常量, 可以修改指针指向的内容, 不能修改指针的值,  ptr2 不可以修改, 也就是 *ptr2, 可以修改,

常量地址n只能赋值给常量指针, 所以ptr3 错误
对于指针常量, 是一个常量, 必须在初始化时赋值, 

const int *const ptr6 = &m;第一个const是常量指针, 第二个是const是指针常量, 必须在初始化时赋值, 所以指针和常量都无法修改


```

## Q:  指针常量与字符串常量的冲突

```c++
//constChar.cpp
 	char * const str = "apple";
    *str = "orange"; //err
    cout << str << endl;
```

初始化指针常量str内容为apple, 把str指向的内容换成orange, 输出为apple 或者报错

 	char * const str = "apple": 在初始化str的过程中, 系统会在常量区的一块空间中写入字符串"apple"并返回首地址, 此时str指向字符串常量区中的常量"apple"的首地址

而 *str = "orange";这句话本身就是错误的, 因为字符串"apple"是作为字符串常量存放在常量区中, 而常量的值不能被修改

修改整个字符串, 对指向字符串的指针str进行赋值, 但str是指针常量 无法修改, 所以str必须为普通值

## Q: 数组指针与二维数组的区别

说出一下代码输出

```c++
 	int a[2][5] = {{1, 2, 3, 4, 5},{6, 7, 8, 9, 10}};
    int (*p)[5] = a;//数组指针, 这里有一个性质, 数组名等于数组首元素等于 &a[0]
    cout << p << endl;
    cout << p + 1 << endl;
    
    cout << *p << endl;
    cout << *(p + 1) << endl;
    cout << *p + 1  << endl;
    
    cout << **p << endl;
    cout << **(p + 1) << endl;
    cout << *(*p + 1) << endl;
输出:
    0x7ffe8507eab0
    0x7ffe8507eac4 //p + 1是数组第二个元素的地址即 &a[1], 因为5个int元素, 所以偏移20个, 16进制, 进位+ 4
    0x7ffe8507eab0 //因为p = &a[0], 量表解引用, *p = a[0]
    0x7ffe8507eac4 //同上输出a[1][0]
    0x7ffe8507eab4 //地址加一个int元素偏移, + 4
        
    1	//**取内容 同上推出
    6
    2
```

## Q: 简述指针数组与指向指针的指针的区别

```c++
    char *str[4] = {"welcome", "to", "new", "Beijing"};
    char **p = str + 1; //指向指针的指针 是str的首位, str + 1 相当于指向str[1]

    str[0] = (*p++) + 1; //指向 str[1]中to的o
    str[1] = *(p + 1); //指向Beijing的第一个字符串 B
    str[2] = p[1] + 3; //往后移动三个字符指向 j
    str[3] = p[0] + (str[2] - str[1]); //两个指针相减, 表示他们之间间隔的个数, 实际上指向是p[0] + 3, 指向g

输出:
输出实际上是从第一个字符到最后一个结束字符 
结果:
o
Beijing
jing
g
```

## Q: 简述指向指针的指针

```c++
	int a = 10, b = 20;
    int *q = &a;
    int **p = &q;
    **p = 30;
    
    cout << a << endl;
    cout << b << endl;

输出:	
30
20
```

指针指向指针, 称为指向指针的指针,p 指向指针的指针, 

指针q指向a, *q等于a, 指针p指向q, *p等于q, 推出**p等于a, 

把最近的星包进去, 就说明这个变量是一个什么类型的变量, 则*p是 int *指针, **p是int类型

## Q: 指针作为参数常见错误

```c++
int find(char *s, char ch, char *sub) {
    for (int i = 0; *(s + i) != '\0'; i++) {
        if (*(s + i) == ch) {
           sub = s +i + 1;
            return i;
        }
    }
    return 0;
}

//////////////////////////////////
char fullName[] = {"Jordan#Michael"};
char *givenName;
int cnt = find(fullName, '#', givenName);
cout << givenName << "has a " << cnt << " characters'family name" << endl;
```

答案不对, 在find函数调用前 givenName没有初始化, 指向一个随机的地址空间, 调用find函数时, 将givenName的地址作为参数传递给形参sub, sub值发生变化, 将分隔符后面字符的地址赋值给sub,指向J, 而此时givenName的值并没有发生变化, 仍是指向原来的空间.函数调用后, givenName仍旧没有被初始化和赋值.

```c++
int find2(char *s, char ch, char **psub) {
    for (int i = 0; *(s + i) != '\0'; i++) {
        if (*(s + i) == ch) {
            *psub = s +i + 1;
            return i;
        }
    }
    return 0;
}
//////////////////////////////////
 char fullName2[] = {"Jordan#Michael"};
    char *givenName2 = NULL;
    int cnt2 = find2(fullName2, '#', &givenName2);
    cout << givenName2 << " has a " << cnt2 << " characters'family name" << endl;
```

此时, 将givenName的地址作为参数传递给find函数的形参psub, 此时find函数内修改会修改givenName

## Q: 函数指针基本用法

```c++
int max(int a, int b) {
    return  a > b ? a : b;
}
int (*p)(int, int) = max;
int main() {
    int x = 10;
    int y = 20;
    //这两种写法相等,
    //int z = p(x, y);
    int z = (*p) (x, y);
    cout << z << endl;
    return 0;
}
```

指针变量可以指向任何类型的数据, 也可以指向函数

每个函数在内存中都占一段存储单元, 这段存储单元地址称为函数入口地址, 指向这个函数入口地址的指针称为函数指针

注意类型要匹配, 括号不可少

## Q: 通过函数指针进行四则运算

第一版, 可扩展性差

```c++
#include <iostream>

using namespace std;

int add(int a, int b) { return  a + b;}
int myMinus(int a, int b) { return a - b;}
int multi(int a, int b) { return  a * b;}

int process(int a, int b, char operation) {
    switch (operation) {
        case '+':
            return add(a, b);
        case '-':
            return myMinus(a, b);
        case '*':
            return multi(a, b);
        default:
            return 0;
    }
}

int main() {

    int a = 10, b = 20;
    int res1 = process(a, b, '+');
    int res2 = process(a, b, '-');
    int res3 = process(a, b, '*');

    cout << res1 << " " << res2 << " " << res3 << endl;

    return 0;
}
```

优化版

```c++
#include <iostream>

using namespace std;

int add(int a, int b) { return  a + b;}
int myMinus(int a, int b) { return a - b;}
int multi(int a, int b) { return  a * b;}

int process(int a, int b, int (*func) (int, int)) {
    return func(a, b);
}

int main() {
    int a = 10, b = 20;
    int res1 = process(a, b, add);
    int res2 = process(a, b, myMinus);
    int res3 = process(a, b, multi);
    cout << res1 << " " << res2 << " " << res3 << endl;
    return 0;
}
```

## Q: this指针

面向对象程序设计中, 每个非静态成员变量都包含一个特殊的指针, 指向调用该函数的对象, 称为this指针, 当对象访问类中的非静态成员变量时, 编译器会自动将对象的地址隐式的传递给this指针, 在非静态成员函数中访问非静态成员变量都隐式的调用了this指针.

## Q: this指针常识问题

下面哪个说法是正确的

1. 调用类的成员函数时, 对象的地址会隐式地作为第一个参数传递给this指针
2. 通过取地址符&可以获得this指针的地址
3. 对象进行sizeof运算时会加上this指针所占用的空间
4. 不能对this指针进行赋值

解析:

1.  只有在访问非静态成员函数时编译器才会将对象的地址隐式地作为第一个参数传给this, 在访问类的静态成员函数时并不会如此, 因此A是错误的
2. this指针是一种特殊的指针, 无法直接获取this指针的指针, 如果用&来获取this指针, 编译器会报错
3. 由于this指针只能访问非静态成员的对象本身, 而不能指向其他的对象, 因此this指针是一个常量, 不能够修改this指针的值.