/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-01
 * Time: 下午10:05
 */

package main

import (
	"math/rand"
	"os"
)

func main() {
	freq := rand.Float64() * 3.0
	t := 0.0
	i := 100
	var boling float64 = 100

	var name []string
	var err error
	var p Point

	i, j := 0, 1

	//swap value
	i, j = j, i

	f, err := os.Open(name)
	if err != nil {
		return err
	}

	f.Close()
	//简短声明变量, 必须要有一个新的值 否则不能编译通过

	in, err := os.Open(infile)
	out, err := os.Open(outfile)

	//下面的不能编译通过
	f, err := os.Open(infile)
	f, err := os.Open(outfile)
}
