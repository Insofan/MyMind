/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-26
 * Time: 下午11:08
 */

package main

import (
	"MyMind/TheGoProgrammingLanguage/ch5/links"
	"fmt"
	"log"
	"os"
)

func main() {
	worklist := make(chan []string)

	//Start with cmd
	go func() { worklist <- os.Args[1:] }()

	seen := make(map[string]bool)

	for list := range worklist {
		for _, link := range list {
			seen[link] = true
			go func(link string) {
				worklist <- crawl(link)
			}(link)
		}
	}
}

func crawl(url string) []string {
	fmt.Println(url)
	list, err := links.Extract(url)
	if err != nil {
		log.Print(err)
	}
	return list
}
