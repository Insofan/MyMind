/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-04
 * Time: 下午12:36
 */

package main

import (
	"encoding/json"
	"fmt"
	"io"
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
	jsonFile, err := os.Open("ch7/jsonParsing/post.json")

	if err != nil {
		fmt.Println("Err opening json :", err)
		return
	}

	defer jsonFile.Close()

	decoder := json.NewDecoder(jsonFile)

	for {
		var post Post
		err := decoder.Decode(&post)
		if err == io.EOF {
			break
		}

		if err != nil {
			fmt.Println("Error decoding json: ", err)
		}
		fmt.Println(post)
	}

	/*

		jsonData, err := ioutil.ReadAll(jsonFile)

		if err != nil {
			fmt.Println("Error reading JSON data: ", err)
			return
		}

		var post Post
		if err := json.Unmarshal(jsonData, &post); err != nil {
			log.Fatalln(err)
		}
		fmt.Println(post)
	*/

}
