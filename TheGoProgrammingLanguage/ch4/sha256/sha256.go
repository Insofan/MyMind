/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-03
 * Time: 下午10:34
 */

package main

import (
	"crypto/sha256"
	"fmt"
)

func main() {
	c1 := sha256.Sum256([]byte("x"))
	c2 := sha256.Sum256([]byte("X"))
	fmt.Printf("%x \n %x \n %t \n %T \n ", c1, c2, c1 == c2, c1)
}
