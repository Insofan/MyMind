//
//  pointer.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/7.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

func main() {

	// 报错
	//m := map[string]int{"a", 1}
	//println(&m["a"])

	x := 10
	p := &x

	p++ //报错
	var p2 *int = p + 1 //无效操作

	p2 = &x
	println(p == p2)
}