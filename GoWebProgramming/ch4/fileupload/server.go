/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-30
 * Time: 下午11:45
 */

package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func process(w http.ResponseWriter, r *http.Request) {
	r.ParseMultipartForm(1024)
	//对应file里面的name

	//fileHeader := r.MultipartForm.File["uploaded"][0]
	//file, err := fileHeader.Open()
	//用http内置formfile代替上面两行代码
	file, _, err := r.FormFile("uploaded")
	if err == nil {
		data, err := ioutil.ReadAll(file)
		if err == nil {
			fmt.Fprintln(w, string(data))
		}
	}
}

func main() {
	server := http.Server{
		Addr: "127.0.0.1:8080",
	}
	http.HandleFunc("/process", process)
	server.ListenAndServe()
}
