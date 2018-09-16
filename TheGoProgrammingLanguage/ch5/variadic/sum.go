/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午10:37
 */

package main

import "fmt"

func sum(vals ...int) int {

	total := 0
	for _, val := range vals {
		total += val
	}
	return total
}

func main() {
	res := sum(1, 2, 3, 4, 5)
	fmt.Println(res)
	values := []int{1, 2, 3, 4}
	fmt.Println(sum(values...))

}
