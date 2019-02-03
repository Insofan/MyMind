//
//  slice.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/3.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "fmt"

func main() {
	x := make([]int, 0, 5)

	for i:= 0; i < 8; i++ {
		x = append(x, i) // 超出5时自动扩容
	}

	fmt.Println(x)
}