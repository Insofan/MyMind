/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-14
 * Time: 下午9:06
 */

package main

import (
	"../tempconv"
	"flag"
	"fmt"
)

//其中name 是flag的-的参数 20 是默认值, usage是提示
//可以用作命令行
var temp = tempconv.CelsiusFlag("temp", 20.0, "the temprature")

func main() {
	flag.Parse()
	fmt.Println(*temp)
}
