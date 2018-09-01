/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-01
 * Time: 下午9:39
 */

package main

import "fmt"

func main() {
	const freezingF, boilingF = 32.0, 212.0
	//%f %g %e g 输出大的浮点数, e输出 科学计数 3.14159...
	fmt.Printf("boiling point = %g F or %g C\n", freezingF, fToC(freezingF))
	fmt.Printf("boiling point = %g F or %g C\n", boilingF, fToC(boilingF))
}

func fToC(f float64) float64 {
	return (f - 32) * 5 / 9
}
