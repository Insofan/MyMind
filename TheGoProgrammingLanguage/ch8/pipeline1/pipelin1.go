/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-18
 * Time: 下午10:25
 */

package main

import "fmt"

func main() {
	naturals := make(chan int)
	squares := make(chan int)

	//Counter
	go func() {
		for x := 0; ; x++ {
			naturals <- x
		}
	}()

	//Squarer
	go func() {
		for {
			x := <-naturals
			squares <- x * x
		}
	}()

	//Printer in main goroutine

	for {
		fmt.Println(<-squares)
	}
}
