/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-16
 * Time: 下午12:35
 */

package main

import (
	"fmt"
	"log"
	"net/http"
)

type dollars float32
type database map[string]dollars

func main() {
	db := database{"shoes": 30, "socks": 5}
	mux := http.NewServeMux()

	mux.Handle("/list", http.HandlerFunc(db.list))
	mux.Handle("/price", http.HandlerFunc(db.price))
	log.Fatal(http.ListenAndServe("localhost:8000", mux))
}

func (d dollars) String() string {
	return fmt.Sprintf("$%.2f\n", d)
}

//通过http.HandlerFunc 将list 转换为ServeHTTP, 实现接口
func (db database) list(w http.ResponseWriter, r *http.Request) {
	for item, price := range db {
		fmt.Fprintf(w, "%s: %s\n", item, price)
	}
}

func (db database) price(w http.ResponseWriter, req *http.Request) {
	item := req.URL.Query().Get("item")
	price, ok := db[item]
	if !ok {
		w.WriteHeader(http.StatusNotFound)
		fmt.Fprintf(w, "no such item: %q\n", item)
		return
	}
	fmt.Fprintf(w, "%s\n", price)
}
