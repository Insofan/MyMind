/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-17
 * Time: 下午11:46
 */

package main

import (
	"fmt"
	"time"
)

/*
函数启动时, main函数在一个goroutine中执行, 我们叫他main goroutine, go新开一个线程显示动画,go 语句本身会迅速返回, 当main函数执行完成,主函数返回, 所有goroutine都会被打断, 程序退出
*/
func main() {
	go spinner(100 * time.Microsecond)
	const n = 45
	fibN := fib(n)
	fmt.Printf("\rFibonacci(%d) = %d\n", n, fibN)
}

func spinner(delay time.Duration) {
	for {
		for _, r := range `-\|/` {
			//\r 是回车
			fmt.Printf("\r%c", r)
			time.Sleep(delay)
		}
	}
}

func fib(x int) int {
	if x < 2 {
		return x
	}
	return fib(x-1) + fib(x-2)
}
