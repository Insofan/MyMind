//
//  map.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/3.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "fmt"

func main() {
	m := make(map[string]int)
	m["a"] = 1

	x, ok := m["b"]

	fmt.Println(x, ok)

	delete(m, "a")
}