/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-01
 * Time: 下午9:34
 */

package main

import "fmt"

const boilingF float32 = 212.0

func main() {
	var f = boilingF
	var c = (f - 32) * 5 / 9

	//%f %g %e g 输出大的浮点数, e输出 科学计数 3.14159...
	fmt.Printf("boiling point = %g F or %g C\n", f, c)

}
