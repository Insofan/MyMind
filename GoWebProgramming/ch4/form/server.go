/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-30
 * Time: 下午10:35
 */

package main

import (
	"fmt"
	"net/http"
)

func process(w http.ResponseWriter, r *http.Request) {
	//r.ParseForm()
	//获取url 加 post
	//fmt.Fprintln(w, r.Form)
	//只获取post部分, 但是PostForm只支持 application/x-www-form-urlencoded编码, 所以要用multipartform来获取multipart/form-data编码的表单
	//fmt.Fprintln(w, r.PostForm)
	r.ParseMultipartForm(1024)
	//这里go 语言改变了
	fmt.Fprintln(w, "r.MultipartForm", r.MultipartForm)
	fmt.Fprintln(w, "r.FormValue", r.FormValue("hello"))
	fmt.Fprintln(w, "r.PostFormValue", r.PostFormValue("hello"))
	fmt.Fprintln(w, "r.Form", r.Form)
}
func main() {
	server := http.Server{
		Addr: ":8080",
	}

	http.HandleFunc("/process", process)
	server.ListenAndServe()

}
