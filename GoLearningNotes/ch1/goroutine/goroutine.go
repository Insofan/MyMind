//
//  goroutine.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/3.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

import (
	"fmt"
	"time"
)

func task(id int)  {
	for i := 0; i < 5; i++ {
		fmt.Printf("%d: %d\n", id, i)
		time.Sleep(time.Second)
	}

}

func main() {
	go task(1)
	go task(2)

	time.Sleep(time.Second * 6)

}