package main

import (
	"fmt"
	"os"
)

func main() {
	s, sep := "", ""
	/*
		var s = ""
		var s string = ""
	*/
	//注意os.args从1开始 从0开始会打印 /tmp/go-build394919105/b001/exe/echo2
	for _, arg := range os.Args[1:] {
		s += sep + arg
		sep = " "
	}
	fmt.Println(s)
}
