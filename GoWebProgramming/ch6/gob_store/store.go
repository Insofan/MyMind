/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-03
 * Time: 上午12:27
 */

package main

import "fmt"

type Post struct {
	Id      int
	Content string
	Author  string
}

var PostById map[int]*Post
var PostsByAuthor map[string][]*Post

func store(post Post) {
	PostById[post.Id] = &post
	PostsByAuthor[post.Author] = append(PostsByAuthor[post.Author], &post)
}
func main() {
	PostById = make(map[int]*Post)
	PostsByAuthor = make(map[string][]*Post)

	post1 := Post{1, "Hello World!", "Insomnia"}
	post2 := Post{2, "Bonjour Monde!", "Pierre"}
	post3 := Post{3, "Hola Mundo!", "Pedro"}
	post4 := Post{4, "Greetings Earthlings!", "Insomnia"}

	store(post1)
	store(post2)
	store(post3)
	store(post4)

	fmt.Println(PostById[1])
	fmt.Println(PostById[2])

	for _, post := range PostsByAuthor["Insomnia"] {
		fmt.Println(post)
	}
	for _, post := range PostsByAuthor["Pedro"] {
		fmt.Println(post)
	}

}
