/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-03
 * Time: 下午10:50
 */

package main

import "fmt"

func main() {
	a := [...]int{0, 1, 2, 3, 4, 5}
	//注意 这里切片直接就有了引用, 相当于 c++ &, 传进reverse修改的是a的原值, 并不是副本
	//slice 无法像arr 一样直接比较==
	reverse(a[:])
	fmt.Println(a)

	b := make([]int, 3, 5)

	fmt.Printf("b : %d %T\n", len(b), cap(b))
	fmt.Printf("b : %d \n", len(b))
}

func reverse(s []int) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}
