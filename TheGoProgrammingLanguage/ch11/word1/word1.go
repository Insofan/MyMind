/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-28
 * Time: 下午9:26
 */

package word1

//go test , go test -v
func IsPalindrome(s string) bool {
	for i := range s {
		if s[i] != s[len(s)-1-i] {
			return false
		}
	}
	return true
}
