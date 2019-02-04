//
//  enum.go
//  GoLearningNotes 
//
//  Created by Inso on 2019/2/4.
//  Copyright © 2019 Inso. All rights reserved.
//
package main

func main() {
	const (
		x = iota // 0
		y // 1
		z // 2
	)

	//如果iota自增被中断, 需要显示回复
	const (
		a = iota
		b
		c = 100
		d
		e = iota
		f
	)

}