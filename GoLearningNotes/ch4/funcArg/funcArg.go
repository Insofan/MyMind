/**
 * Created with Goland.
 * Description: 
 * User: Insomnia
 * Date: 2019-02-14
 * Time: 上午12:16
 */

package main


type FormatFunc func(string, ...interface{}) (string, error)

func format(f FormatFunc, s string, a ...interface{}) (string, error) {
	return f(s, a...)
}

func main() {

}
