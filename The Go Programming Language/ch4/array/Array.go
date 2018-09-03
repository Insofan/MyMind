/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-03
 * Time: 下午10:13
 */

package main

import "fmt"

type Currency int

const (
	USD Currency = iota
	EUR
	GBP
	RMB
)

func main() {
	var a [3]int
	fmt.Println(a[0])
	fmt.Println(a[len(a)-1])

	for i, v := range a {
		fmt.Printf("%d %d\n", i, v)
	}

	for _, v := range a {
		fmt.Println(v)
	}

	//var  q [3]int = [3]int{1, 2, 3}
	var r [3]int = [3]int{1, 2}
	//print 0
	fmt.Println(r[2])

	q := [...]int{1, 2, 3}
	fmt.Printf("%T\n", q)

	symbol := [...]string{USD: "$", EUR: "E", GBP: "G", RMB: "R"}
	fmt.Println(RMB, symbol[RMB])

	other()
}

func other() {
	a := [2]int{1, 2}
	b := [...]int{1, 2}
	c := [2]int{1, 3}
	fmt.Println(a == b, a == c, b == c)
	d := [3]int{1, 2}
	//编译器会报错
	//fmt.Println(a == d)

}
