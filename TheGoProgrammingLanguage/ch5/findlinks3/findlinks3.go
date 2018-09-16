/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午9:55
 */

package main

import (
	"../links"
	"fmt"
	"os"
)

func breathFirst(f func(item string) []string, worklist []string) {
	seen := make(map[string]bool)
	for len(worklist) > 0 {
		items := worklist
		worklist = nil
		for _, item := range items {
			if !seen[item] {
				seen[item] = true
				worklist = append(worklist, f(item)...)
			}
		}
	}
}

func craw(url string) []string {
	fmt.Println(url)

	list, err := links.Extract(url)
	if err != nil {
		fmt.Println(err)
	}
	return list
}

func main() {
	//./findlinks3 https://baidu.com
	breathFirst(craw, os.Args[1:])
}
