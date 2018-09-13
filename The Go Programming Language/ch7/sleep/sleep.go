/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-13
 * Time: 下午11:25
 */

package main

import (
	"flag"
	"fmt"
	"time"
)

//建一个 -flag
var period = flag.Duration("period", 1*time.Second, "sleep period")

func main() {

	flag.Parse()
	fmt.Printf("Sleeping for %v...", *period)
	time.Sleep(*period)
	fmt.Println()
}
