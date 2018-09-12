/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-12
 * Time: 下午10:51
 */

package main

import (
	"fmt"
	"log"
	"net/http"
)

type HelloHandler struct{}

func (h *HelloHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello ")
}

type WorldHandler struct{}

func (h *WorldHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "World")

}

func main() {

	server := http.Server{
		Addr: "127.0.0.1:8080",
	}

	hello := HelloHandler{}
	world := WorldHandler{}

	http.Handle("/hello", &hello)
	http.Handle("/world", &world)

	//http2.ConfigureServer(&server, &http2.Server{})
	//err := server.ListenAndServeTLS("cert.pem", "key.pem")
	err := server.ListenAndServe()
	if err != nil {
		log.Fatal(err)
	}
}
