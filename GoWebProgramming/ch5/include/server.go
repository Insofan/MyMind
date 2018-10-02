/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-02
 * Time: 下午12:53
 */

package main

import "net/http"
import "text/template"

func process(w http.ResponseWriter, r *http.Request) {
	//为了向 t2 里面传递参数 需要在 {{template "t2.html"}} 添加 .  {{template "t2.html" .}}
	t, _ := template.ParseFiles("ch5/include/t1.html", "ch5/include/t2.html")
	t.Execute(w, "Hello World!")

}
func main() {
	server := http.Server{
		Addr: ":8080",
	}
	http.HandleFunc("/process", process)
	server.ListenAndServe()
}
