//
//  errAssign.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/4.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "os"

func main() {
	f, err := os.Open("/dev/random")

	buf := make([]byte, 1024)

	n, err := f.Read(buf)
	println(n, err)
}