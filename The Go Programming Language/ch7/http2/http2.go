/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-16
 * Time: 上午11:52
 */

package main

import (
	"fmt"
	"log"
	"net/http"
)

type dollors float32

func (d dollors) String() string {
	return fmt.Sprintf("$%.2f", d)
}

type database map[string]dollors

func (db database) ServeHTTP(w http.ResponseWriter, req *http.Request) {
	switch req.URL.Path {
	case "/list":
		for item, price := range db {
			fmt.Fprintf(w, "%s: %s\n", item, price)
		}
	case "/price":
		//http://localhost:8000/price?item=shoes
		item := req.URL.Query().Get("item")
		price, exist := db[item]
		if !exist {
			w.WriteHeader(http.StatusNotFound)
			fmt.Fprintf(w, "no such item: %q\n", item)
			return
		}

		fmt.Fprintf(w, "%s\n", price)
	default:
		w.WriteHeader(http.StatusNotFound)
		fmt.Fprintf(w, "no such page: %s\n", req.URL)
	}
}

func main() {
	db := database{"shoes": 50, "socks": 5}
	log.Fatal(http.ListenAndServe("localhost:8000", db))
}
