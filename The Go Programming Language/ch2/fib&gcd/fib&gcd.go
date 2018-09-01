/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-01
 * Time: 下午10:43
 */

package main

import "fmt"

func main() {
	//最大公约数
	gcdRes := gcd(10, 4)
	fmt.Println(gcdRes)
	fibRes := fib(9)
	fmt.Println(fibRes)

}

func fib(n int) int {
	x, y := 0, 1
	for i := 0; i < n; i++ {
		x, y = y, x+y
	}
	return x
}

func gcd(x, y int) int {
	for y != 0 {
		x, y = y, x%y
	}
	return x
}
