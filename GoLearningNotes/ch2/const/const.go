//
//  const.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/4.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "fmt"

func main() {

	const x, y int = 123, 0x22
	const s = "hello, world"
	const c = '我' //rune (unicode code point)
	const(
	i, f = 1, 01
	)

	const (
		a  uint16 = 120
		b
		e = "abc"
		d
	)

	fmt.Printf("%T, %v\n", b, b)
	fmt.Printf("%T, %v\n", d, d)
}