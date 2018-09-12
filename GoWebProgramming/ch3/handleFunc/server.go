/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-13
 * Time: 上午12:15
 */

package main

import (
	"fmt"
	"net/http"
)

func hello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "HELLO")
}

func world(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "WORLD!")
}
func main() {

	server := http.Server{
		Addr: "127.0.0.1:8080",
	}

	http.HandleFunc("/hello", hello)
	http.HandleFunc("/world", world)

	server.ListenAndServe()

}
