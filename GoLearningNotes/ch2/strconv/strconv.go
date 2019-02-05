//
//  strconv.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/6.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "strconv"

func main() {
	a, _ := strconv.ParseInt("1100100", 2, 32)
	b, _ := strconv.ParseInt("0144", 8, 32)
	c, _ := strconv.ParseInt("64", 16, 32)

	println(a, b, c)

	println("0b" + strconv.FormatInt(a, 2))
	println("0" + strconv.FormatInt(b, 8))
	println("0x" + strconv.FormatInt(c, 16))
}