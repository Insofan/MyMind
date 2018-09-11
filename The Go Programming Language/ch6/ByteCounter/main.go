/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-11
 * Time: 下午11:27
 */

package main

import "fmt"

//是一个整数
type ByteCount int

func (c *ByteCount) Write(p []byte) (int, error) {
	*c += ByteCount(len(p)) // convert int to ByteConter
	return len(p), nil
}

func main() {
	var c ByteCount
	c.Write([]byte("Hello"))
	fmt.Println(c)

	b := ByteCount(3)
	fmt.Println(b)

	//因为 c 是ByteCount, 它满足Write的约定, 实际上就是iOS中的协议, 所以&c可以传入 Fprintf中, 会正确的计算长度
	c = 0 // reset c
	var name = "Dolly"
	fmt.Fprintf(&c, "hello, %s", name)
	fmt.Println(c) // "12, = len("hello, Dolly")
}
