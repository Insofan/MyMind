/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-04
 * Time: 下午1:19
 */

package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"path"
	"strconv"

	"github.com/jinzhu/gorm"
)

type Post struct {
	gorm.Model
	//Id      int    `json:"id"`
	Content string `json:"content"`
	Author  string `json:"author"`
}

//run的时候将goland 的run config 设置成package
func main() {
	server := http.Server{
		Addr: "127.0.0.1:8080",
	}

	http.HandleFunc("/post/", handleRequest)

	server.ListenAndServe()
}

func handleRequest(w http.ResponseWriter, r *http.Request) {
	var err error
	switch r.Method {
	case "GET":
		err = handleGet(w, r)
	case "POST":
		err = handlePost(w, r)
	case "PUT":
		err = handlePut(w, r)
	case "DELETE":
		err = handleDelete(w, r)
	}

	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

// curl -i -X GET http://127.0.0.1:8080/post/1 id 根据
func handleGet(w http.ResponseWriter, r *http.Request) (err error) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))

	if err != nil {
		fmt.Println(err)
		return
	}

	post, err := retrieve(id)
	if err != nil {
		return
	}

	output, err := json.MarshalIndent(&post, "", "\t\t")
	if err != nil {
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return

}

//创建帖子
// curl -i -X POST -H "Content-Type: application/json"  -d '{"content":"My first post",
// "author":"Insomnia"}' http://127.0.0.1:8080/post/1 后面的/1换成需要的id
func handlePost(w http.ResponseWriter, r *http.Request) (err error) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	var post Post
	json.Unmarshal(body, &post)
	err = post.create()
	if err != nil {
		return
	}

	w.WriteHeader(200)
	return

}

//更新帖子
// curl -i -X PUT -H "Content-Type: application/json"  -d '{"content":"Updated post","author":"Insomnia"}' http://127.0.0.1:8080/post/1
func handlePut(w http.ResponseWriter, r *http.Request) (err error) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}

	post, err := retrieve(id)
	if err != nil {
		return
	}

	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	json.Unmarshal(body, &post)
	err = post.update()
	if err != nil {
		return
	}

	w.WriteHeader(200)
	return
}

//curl -i -X DELETE http://127.0.0.1:8080/post/1
func handleDelete(w http.ResponseWriter, r *http.Request) (err error) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}

	post, err := retrieve(id)
	if err != nil {
		return
	}

	err = post.delete()
	if err != nil {
		return
	}
	w.WriteHeader(200)
	return
}
