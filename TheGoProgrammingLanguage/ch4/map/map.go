/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-04
 * Time: 下午9:43
 */

package main

import "fmt"

func main() {
	//ages := make(map[string]int)
	args := map[string]int{
		"alice":   31,
		"charlie": 34,
	}

	fmt.Println(args["alice"])
	delete(args, "alice")
	fmt.Println(args["alice"])
	args["bob"] = args["bob"] + 1
	args["bob"] += 1
	args["bob"]++
	fmt.Println(args["bob"])
	// complier error, map 不能取地址
	//_ = &args["bob"]

	if age, ok := args["doxy"]; !ok {
		fmt.Println(age)
	}
}
