/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-26
 * Time: 下午11:56
 */

package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	abort := make(chan struct{})
	go func() {
		os.Stdin.Read(make([]byte, 1))
		abort <- struct{}{}
	}()

	fmt.Println("Commencing countdown. Press return to abort.")

	select {
	case <-time.After(10 * time.Second):
		fmt.Println("10 after launch")
	case <-abort:
		fmt.Println("launch aborted!")
		return

	}
}
