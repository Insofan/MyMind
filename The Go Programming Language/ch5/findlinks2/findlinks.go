/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午4:44
 */

package main

import (
	"flag"
	"fmt"
	"golang.org/x/net/html"
	"net/http"
)

func main() {

}

func findlinks(url string) ([]string, error) {
	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}

	if resp.Status != http.StatusOK {
		resp.Body.Close()
		return nil, fmt.Errorf("getting %s: %s", url, resp.Status)
	}

	doc, err := html.Parse(resp.Body)
	resp.Body.Close()
	if err != nil {
		return nil, fmt.Errorf("getting %s: %s", url, resp.Status)
	}

	return visit(nil, doc), nil
}
