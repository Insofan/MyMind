//
//  init.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/7.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

type data struct {
	x int
	s string
}

func main() {

	var a data = data{1, "abc"}

	b := data{
		1,
		"abc",
	}

	println(a, b)
}