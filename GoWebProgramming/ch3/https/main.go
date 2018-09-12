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

	"golang.org/x/net/http2"
)

type MyHandler struct{}

func (h *MyHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello https server")
}

func main() {

	handler := MyHandler{}
	server := http.Server{
		Addr:    "127.0.0.1:8080",
		Handler: &handler,
	}

	http2.ConfigureServer(&server, &http2.Server{})
	err := server.ListenAndServeTLS("cert.pem", "key.pem")
	if err != nil {
		log.Fatal(err)
	}
}
