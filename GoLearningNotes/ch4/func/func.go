/**
 * Created with Goland.
 * Description: 
 * User: Insomnia
 * Date: 2019-02-13
 * Time: 下午11:58
 */

package main

func hello()  {
	println("hello, world!")
}

func exec(f func())  {
	f()
}

func main()  {
	/*
	func add(x, y int) int {
		return x + y
	}
	*/

	f := hello
	exec(f)
}
