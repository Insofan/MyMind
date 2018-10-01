/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-01
 * Time: 下午11:27
 */

package main

import (
	"fmt"
	"net/http"
)

func writeExample(w http.ResponseWriter, r *http.Request) {
	str := `<html>
<head><title>Go Web Programming</title></head>
<body><h1>Hello world</h1></body>
</html>`
	//	w.Write([]byte(str))
	fmt.Fprintln(w, str)
}

func writeHeaderExample(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(501)
	fmt.Fprintln(w, "No such service, try next door")
	/*
				HTTP/1.1 200 OK
		Date: Mon, 01 Oct 2018 15:42:58 GMT
		Content-Length: 96
		Content-Type: text/html; charset=utf-8

		<html>
		<head><title>Go Web Programming</title></head>
		<body><h1>Hello world</h1></body>
		</html>

	*/
}

func headerExample(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Location", "http://google.com")
	w.WriteHeader(302)
	/*
			HTTP/1.1 302 Found
		Location: http://google.com
		Date: Mon, 01 Oct 2018 15:46:11 GMT
		Content-Length: 0

	*/
}

func main() {
	server := http.Server{
		Addr: "127.0.0.1:8080",
	}
	//curl -i 127.0.0.1:8080/write
	http.HandleFunc("/write", writeExample)
	// curl -i 127.0.0.1:8080/writeheader
	http.HandleFunc("/writeheader", writeHeaderExample)
	http.HandleFunc("/redirect", headerExample)
	server.ListenAndServe()
}
