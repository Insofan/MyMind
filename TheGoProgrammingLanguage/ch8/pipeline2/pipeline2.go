/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-18
 * Time: 下午10:35
 */

package main

import "fmt"

func main() {

	naturals := make(chan int)
	squares := make(chan int)

	//Counter
	go func() {
		for x := 0; x < 100; x++ {
			naturals <- x
		}
		close(naturals)
	}()

	//Squarer
	go func() {
		for x := range naturals {
			squares <- x * x
		}

		close(squares)
	}()

	//Printer in main goroutine

	for x := range squares {
		fmt.Println(x)
	}

}
