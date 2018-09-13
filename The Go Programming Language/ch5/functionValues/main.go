/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午8:52
 */

package main

import "fmt"

func main() {
	//函数是值的类型, 可以作为type当做参数的类型
	f := square
	fmt.Println(f(3))
	f = negative
	fmt.Printf("%T\n", f)

	//编译器报错
	//f = product
	//fmt.Printf("%T\n", f)

	var g func(int) int

	if g != nil {
		g(3)
	}

}

func square(n int) int { return n * n }

func negative(n int) int { return -n }

func product(m, n int) int { return m * n }
