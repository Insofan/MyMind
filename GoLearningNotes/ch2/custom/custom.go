//
//  custom.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/6.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "fmt"

type flags byte
	const (
		read flags = 1 << iota
		write
		exec
	)

func main() {

	f := read | exec
	fmt.Printf("%b\n", f)

}