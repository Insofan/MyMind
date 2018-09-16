package main

import (
	"fmt"
	"os"
)

/**
  go 命令行输入参数
*/
func main() {
	var s, sep string
	//注意 go 不可以 ++i
	for i := 1; i < len(os.Args); i++ {
		s += sep + os.Args[i]
		sep = " "
	}
	fmt.Println(s)
}
