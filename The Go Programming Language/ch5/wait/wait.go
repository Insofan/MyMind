/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午6:12
 */

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	//reader := bufio.NewReader(os.Stdin)
	//para, err := reader.ReadString('\n')
	para := os.Args[1:]

	//if err != nil {
	//	fmt.Println("err happen")
	//	os.Exit(1)
	//}

	fmt.Println(para[0])
	WaitForServer(para[0])
}

func WaitForServer(url string) error {
	const timeout = 1 * time.Minute
	deadline := time.Now().Add(timeout)
	for tries := 0; time.Now().Before(deadline); tries++ {
		_, err := http.Head(url)
		if err == nil {
			os.Exit(1)
			return nil
		}

		log.Printf("server not responding (%s); retrying...", err)
		time.Sleep(time.Second << uint(tries))
	}

	return fmt.Errorf("Server %s failed to respond after %s", url, timeout)
}
