/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-05
 * Time: 下午11:27
 */

package main

import (
	"fmt"
	"gopl.io/ch4/treesort"
)

func main() {
	arr := []int{6, 5, 4, 3, 2, 2, 1}
	treesort.Sort(arr)
	fmt.Println(arr)

}
