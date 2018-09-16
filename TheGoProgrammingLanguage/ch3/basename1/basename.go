/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-02
 * Time: 下午9:52
 */

package main

import (
	"fmt"
	"strings"
)

func basename(s string) string {
	//最后一个 / index
	slash := strings.LastIndex(s, "/")
	s = s[slash+1:]
	if dot := strings.LastIndex(s, "."); dot >= 0 {
		s = s[:dot]
	}
	return s
}

func main() {

	fmt.Println(basename("a/b/c.go"))
	fmt.Println(basename("c.d.go"))

}
