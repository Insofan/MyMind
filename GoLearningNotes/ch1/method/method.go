//
//  method.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/3.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import "fmt"

type user struct {
	name string
	age byte
}

func (u user) ToString() string  {
	return fmt.Sprintf("%+v", u)
}

type manager struct {
	user
	title string
}

func main() {
	var m manager
	m.name = "Tom"
	m.age = 29

	println(m.ToString())
}