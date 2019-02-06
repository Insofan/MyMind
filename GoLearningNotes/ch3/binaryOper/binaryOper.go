//
//  binaryOper.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/7.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "fmt"

func main() {
	const v = 20
	var a byte = 10

	b := v + a
	fmt.Printf("%T, %v\n", b, b)
}