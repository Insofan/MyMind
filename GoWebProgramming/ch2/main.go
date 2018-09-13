/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-12
 * Time: 上午12:11
 */

package main

import "net/http"

func main() {
	mux := http.NewServeMux()

	//begin:处理静态文件
	files := http.FileServer(http.Dir("/public"))
	mux.Handle("/static/", http.StripPrefix("/static/", files))
	//end

	mux.HandleFunc("/", index)
	mux.HandleFunc("/err", err)

	server := &http.Server{
		Addr:    "0.0.0.0:8080",
		Handler: mux,
	}
	server.ListenAndServe()
}
