/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-04
 * Time: 下午9:32
 */

package main

func main() {

}

func empty(strings []string) []string {
	i := 0
	for _, s := range strings {
		if s != "" {
			strings[i] = s
			i++
		}
	}
	return strings[:i]
}
