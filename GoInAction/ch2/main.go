//
//  main.go
//  GoInAction
//
//  Created by Inso on 2018/9/13.
//  Copyright © 2018 Inso. All rights reserved.
//
package main

import (
	_ "MyMind/GoInAction/ch2/matchers"
	"MyMind/GoInAction/ch2/search"
	"log"
	"os"
)

func init() {
	log.SetOutput(os.Stdout)
}

func main() {
	//搜索关键字
	search.Run("president")
}
