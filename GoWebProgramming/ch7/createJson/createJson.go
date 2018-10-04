/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-04
 * Time: 下午1:00
 */

package main

import (
	"encoding/json"
	"fmt"
	_ "io/ioutil"
	"os"
)

type Post struct {
	Id      int    `json:"id"`
	Content string `json:"content"`
	Author  Author `json:"author"`
	//跳跃式访问
	Comments []Comment `json:"comments"`
}

type Author struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

type Comment struct {
	Id      int    `json:"id"`
	Content string `json:"content"`
	Author  string `json:"author"`
}

func main() {

	post := Post{
		Id:      1,
		Content: "HELLO WORLD!",
		Author: Author{
			Id:   2,
			Name: "Insomnia",
		},
		Comments: []Comment{
			Comment{
				Id:      3,
				Content: "Have a great day!",
				Author:  "Adam",
			},
			Comment{
				Id:      4,
				Content: "How are you today?",
				Author:  "Betty",
			},
		},
	}

	/* 手动创建json
	output, err := json.MarshalIndent(&post, "", "\t\t")
	if err != nil {
		fmt.Println("err marshalling json: ", err)
		return
	}

	err = ioutil.WriteFile("ch7/createJson/post.json", output, 0644)
	if err != nil {
		fmt.Println("err writing json: ", err)
		return

	}
	*/

	//用json api
	jsonFile, err := os.Create("ch7/createJson/post2.json")

	if err != nil {
		fmt.Println("err create json: ", err)
		return
	}

	encoder := json.NewEncoder(jsonFile)
	err = encoder.Encode(&post)
	if err != nil {
		fmt.Println("err writing json: ", err)
		return
	}
}
