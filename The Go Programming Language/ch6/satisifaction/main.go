/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-11
 * Time: 下午11:57
 */

package main

import (
	"bytes"
	"io"
	"os"
)

func main() {
	var w io.Writer
	w = os.Stdout
	w = new(bytes.Buffer)
	//w = time.Second complier 报错

	var rwc io.ReadWriteCloser
	rwc = os.Stdout
	//rwc = new(bytes.Buffer) 报错

	w = rwc

	//	rwc = w 报错 没有 bytes.Buffer
}
