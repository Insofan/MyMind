/**
 * Created with Goland.
 * Description: 
 * User: Insomnia
 * Date: 2018-09-09
 * Time: 下午11:50
 */

package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/",handler)
	http.ListenAndServe(":8080", nil)
}

func handler(w http.ResponseWriter, request *http.Request) {
	fmt.Fprintf(w, "Hello World, %s !", request.URL.Path[1:])
}

