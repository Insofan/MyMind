/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午9:05
 */

package main

import "fmt"

func squares() func() int {
	var x int
	return func() int {
		x++
		return x * x
	}
}
func main() {
	//匿名函数 会有状态 有变量引用
	f := squares()
	fmt.Println(f())
	fmt.Println(f())
	fmt.Println(f())

}
