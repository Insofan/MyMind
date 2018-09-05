/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-05
 * Time: 下午11:59
 */

package main

import "fmt"

/*
type Circle struct {
	X, Y, Radius int
}
*/

type Point struct {
	X int
	Y int
}
type Circle struct {
	Point
	Radius int
}

/*
type Wheel struct {
	X, Y, Radius, Spokes int
}
*/

type Wheel struct {
	Circle
	Spokes int
}

func main() {
	var w Wheel
	w.X = 8
	w.Y = 8
	w.Radius = 5
	w.Spokes = 20

	//w = Wheel{8, 8, 5, 20} 这种赋值, 包含匿名的会报错

	w = Wheel{Circle{Point{8, 8}, 5}, 20}

	w = Wheel{
		Circle{
			Point{
				8,
				8,
			},
			5,
		},
		21,
	}

	fmt.Printf("%#v\n", w)
	w.X = 42
	fmt.Printf("%#v\n", w)
}
