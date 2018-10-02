/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-02
 * Time: 下午2:29
 */

package main

import (
	"html/template"
	"math/rand"
	"net/http"
	"time"
)

func process(w http.ResponseWriter, r *http.Request) {
	rand.Seed(time.Now().Unix())
	var t *template.Template

	if rand.Intn(10) > 5 {
		t, _ = template.ParseFiles("ch5/nested3/layout.html", "ch5/nested1/blue_hello.html")
	} else {
		t, _ = template.ParseFiles("ch5/nested3/layout.html")
	}
	//显示调用定义define 模板
	t.ExecuteTemplate(w, "layout", "")

}

func main() {

	server := http.Server{
		Addr: "127.0.0.1:8080",
	}

	http.HandleFunc("/process", process)
	server.ListenAndServe()
}
