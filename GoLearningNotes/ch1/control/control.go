//
//  control.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/3.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

func main() {
	// switch
	x := 100
	switch {
	case x > 0:
		println("x")
	case x < 0:
		println("-x")
	default:
		println("0")
	}

	// while
	y := 0
	for y < 5 {
		println(y)
		y++
	}

	// range
	z := []int{100, 101, 102}
	for i, n := range z {
		println(i, ":", n)
	}
}