//
//  io.go
//  GoInAction
//
//  Created by Inso on 2018/9/17.
//  Copyright © 2018 Inso. All rights reserved.
//
package main

import (
	"fmt"
	"github.com/goinaction/code/chapter3/words"
	"io/ioutil"
	"os"
)

func main() {
	//go vet 检查代码
	//go fmt 格式化代码
	//go doc http
	//godoc -http=:port(端口号)
	fileName := os.Args[1]
	contents, err := ioutil.ReadFile(fileName)
	if err != nil {
		fmt.Println(err)
		return
	}

	text := string(contents)

	count := words.CountWords(text)
	fmt.Printf("There are %d words in your text.\n", count)
}
