/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午11:16
 */

package main

import (
	"fmt"
	"log"
	"time"
)

func main() {

	bigSlowOperation()
	_ := double(4)
}

func bigSlowOperation() {
	defer trace("bigSlowOperation")()
	time.Sleep(10 * time.Second)
}

func trace(msg string) func() {
	start := time.Now()
	log.Printf("enter %s", msg)

	return func() {
		log.Printf("exit %s (%s)", msg, time.Since(start))
	}
}

func double(x int) (result int) {
	defer func() { fmt.Printf("double(%d) = %d\n", x, result) }()
	return x + x
}
