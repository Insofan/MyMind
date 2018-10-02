/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-02
 * Time: 下午1:30
 */

package main

import "net/http"
import (
	"text/template"
)

func process(w http.ResponseWriter, r *http.Request) {
	t, _ := template.ParseFiles("ch5/aware/tmpl.html")
	//content := `I asked: <i>"What's up?"</i>`
	content := `I asked: <i>"What's up?"</i>`
	t.Execute(w, content)
}

func main() {
	server := http.Server{
		Addr: ":8080",
	}
	http.HandleFunc("/process", process)

	server.ListenAndServe()

}
