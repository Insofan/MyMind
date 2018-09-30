/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-30
 * Time: 下午10:35
 */

package main

import (
	"fmt"
	"net/http"
)

func process(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Fprintln(w, r.Form)
}
func main() {
	server := http.Server{
		Addr: ":8080",
	}

	http.HandleFunc("/process", process)
	server.ListenAndServe()

}
