/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-29
 * Time: 下午11:12
 */

package main

import (
	"fmt"
	"net/http"
)

func headers(w http.ResponseWriter, r *http.Request) {
	h := r.Header
	//指定key 获得value
	//h := r.Header["User-Agent"]
	//h := r.Header.Get("Accept-Encoding")
	fmt.Fprintln(w, h)
}
func main() {
	server := http.Server{
		Addr: ":8080",
	}
	//http.ListenAndServe("/headers", headers)
	http.HandleFunc("/headers", headers)
	server.ListenAndServe()
}
