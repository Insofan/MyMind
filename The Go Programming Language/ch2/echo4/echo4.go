/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-01
 * Time: 下午10:17
 */

package main

import (
	"flag"
	"fmt"
	"strings"
)

var n = flag.Bool("n", false, "omit trailing newline")
var sep = flag.String("s", " ", "seperator")

func main() {
	//要先call这个 parse才能update flag
	flag.Parse()
	fmt.Print(strings.Join(flag.Args(), *sep))
	flag.Args()
	if !*n {
		fmt.Println()
	}

}
