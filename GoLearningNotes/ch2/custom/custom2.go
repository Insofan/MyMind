//
//  custom2.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/6.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "fmt"

func main() {

	type (
		user struct {
			name string
			age uint8
		}

		event func(string)bool
	)

	u := user{"Tom", 20}
	fmt.Println(u)

	var f event = func(s string) bool {
		println(s)
		return s != ""
	}

	f("abc")

}