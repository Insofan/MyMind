/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-29
 * Time: 下午11:32
 */

package main

import (
	"fmt"
	"net/http"
)

func body(w http.ResponseWriter, r *http.Request) {
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	fmt.Fprintln(w, string(body))
}

func main() {
	//命令行输入:  curl -id "first_name=inso&last_name=hi" 127.0.0.1:8080/body
	//返回: HTTP/1.1 200 OK
	//Date: Sat, 29 Sep 2018 15:42:43 GMT
	//Content-Length: 29
	//Content-Type: text/plain; charset=utf-8
	//
	//first_name=inso&last_name=hi
	server := http.Server{
		Addr: "127.0.0.1:8080",
	}

	http.HandleFunc("/body", body)
	server.ListenAndServe()
}
