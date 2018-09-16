/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-06
 * Time: 上午12:29
 */

package main

import (
	"../github"
	"fmt"
	"log"
	"os"
)

func main() {
	//输入  ./main repo:golang/go is:open json decoder
	result, err := github.SearchIssues(os.Args[1:])
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("%d issues:\n", result.TotalCount)
	for _, item := range result.Items {
		fmt.Printf("#%-5d %9.9s %55s\n", item.Number, item.User.Login, item.Title)
	}
}
