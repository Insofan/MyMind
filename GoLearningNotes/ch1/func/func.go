//
//  func.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/3.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

func test(x int) func() {
	return func() {
		println(x)
	}
}

func main() {
	x := 100
	f := test(x)
	f()
}