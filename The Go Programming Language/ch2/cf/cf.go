/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-02
 * Time: 下午1:59
 */

package main

import (
	"../tempconv0"
	"fmt"
	"os"
	"strconv"
)

func main() {
	for _, arg := range os.Args[1:] {
		t, err := strconv.ParseFloat(arg, 64)
		if err != nil {
			fmt.Fprintf(os.Stderr, "cf: %v \n", err)
			os.Exit(1)
		}

		f := tempconv0.Fahrenheit(t)

		c := tempconv0.Celsius(t)
		fmt.Printf("C boiling = %.2f\n", tempconv0.BoilingC)
		fmt.Printf("%.2f = %.2f, %.2f = %.2f \n", f, tempconv0.FToC(f), c, tempconv0.CToF(c))
	}
}
