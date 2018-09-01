/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-01
 * Time: 下午4:50
 */

package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"time"
)

func main() {
	start := time.Now()
	ch := make(chan string)
	//goroutine 开启并发, chan 用来线程间通信
	//整个程序是全书第一次并发和线程间通信很经典
	for _, url := range os.Args[1:] {
		//start a goroutine
		go fetch(url, ch)
	}
	for range os.Args[1:] {
		//receive from channel ch
		fmt.Printf(<-ch)
	}
	fmt.Printf("%.2fs elapsed\n", time.Since(start).Seconds())
}

func fetch(url string, ch chan<- string) {
	start := time.Now()
	resp, err := http.Get(url)

	if err != nil {
		ch <- fmt.Sprint(err)
	}

	nbytes, err := io.Copy(ioutil.Discard, resp.Body)
	//防止泄露resource
	resp.Body.Close()
	if err != nil {
		ch <- fmt.Sprintf("while reading %s: %v", url, err)
		return
	}

	secs := time.Since(start).Seconds()
	//原书未打\n
	ch <- fmt.Sprintf("%.2fs %7d %s\n", secs, nbytes, url)

}
