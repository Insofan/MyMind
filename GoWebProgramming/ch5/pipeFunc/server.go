/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-02
 * Time: 下午1:08
 */

package main

import (
	"html/template"
	"net/http"
	"time"
)

func formatDate(t time.Time) string {
	layout := "2006-01-02"
	return t.Format(layout)
}
func process(w http.ResponseWriter, r *http.Request) {
	funcMap := template.FuncMap{"fdate": formatDate}
	t := template.New("tmpl.html").Funcs(funcMap)
	t, _ = t.ParseFiles("ch5/pipeFunc/tmpl.html")
	t.Execute(w, time.Now())
}
func main() {
	server := http.Server{
		Addr: "127.0.0.1:8080",
	}
	http.HandleFunc("/process", process)
	server.ListenAndServe()
}
