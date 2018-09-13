/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午6:21
 */

package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	res, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("read error:", err)
	}

	fmt.Println("res: " + res)
}
