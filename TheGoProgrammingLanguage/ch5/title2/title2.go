/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午10:55
 */

package main

import (
	"fmt"
	"golang.org/x/net/html"
	"net/http"
	"os"
	"strings"
)

//defer

func main() {
	para := os.Args[1:]

	//title(string(para))
	title(para[0])
}

func title(url string) error {

	resp, err := http.Get(url)
	if err != nil {
		return err
	}

	//还可以用在读写文件 和 互斥锁上
	defer resp.Body.Close()

	ct := resp.Header.Get("Content-Type")
	if ct != "text/html" && !strings.HasPrefix(ct, "text/html;") {
		return fmt.Errorf("%s has type %s, not text/html", url, ct)
	}

	doc, err := html.Parse(resp.Body)

	if err != nil {
		return fmt.Errorf("parsing %s as HTML: %v", url, err)
	}
	fmt.Println(doc)

	return nil

}
