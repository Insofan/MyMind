/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-02
 * Time: 下午12:28
 */

package main

import (
	"html/template"
	"math/rand"
	"net/http"
	"time"
)

func process(w http.ResponseWriter, r *http.Request) {
	t, _ := template.ParseFiles("ch5/random/tmpl.html")
	rand.Seed(time.Now().Unix())
	//t.Execute(w, rand.Intn(10) > 5)
	t.Execute(w, rand.Intn(10))
}

func main() {
	server := http.Server{
		Addr: ":8080",
	}
	http.HandleFunc("/process", process)
	server.ListenAndServe()
}
