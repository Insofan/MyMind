/**
 * Created with Goland.
 * Description: 
 * User: Insomnia
 * Date: 2018-09-12
 * Time: 下午10:48
 */

package main

import "net/http"

func main() {
	server := http.Server{
		Addr: "127.0.0.1:8080",
		Handler:nil,
	}

	server.ListenAndServe()
}
