/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-02
 * Time: 上午10:09
 */

package main

import (
	"html/template"
	"net/http"
)

func process(w http.ResponseWriter, r *http.Request) {
	/*
		相当于
		t := template.New("tmpl.html")
		 t , _ := t.ParseFiles("tmpl.html")
	*/
	t, _ := template.ParseFiles("ch5/html/tmpl.html")
	t.Execute(w, "HELLO WROLD")
}

func main() {
	server := http.Server{
		Addr: ":8080",
	}
	http.HandleFunc("/process", process)

	server.ListenAndServe()
}
