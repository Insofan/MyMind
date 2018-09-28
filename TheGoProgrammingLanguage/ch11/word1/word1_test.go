/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-28
 * Time: 下午9:26
 */

package word1

import "testing"

func TestIsPalindrome(t *testing.T) {

	if !IsPalindrome("detartrated") {
		t.Error("IsPalindrome = false")
	}

	if !IsPalindrome("kayak") {
		t.Error("IsPalindrome = false")
	}

}

func TestNonPalinodrome(t *testing.T) {

	if IsPalindrome("palindrome") {
		t.Error("IsPalindrome =true")
	}
}

func TestFrenchPalindrome(t *testing.T) {
	if !IsPalindrome("été") {
		t.Error(`IsPalindrome("été") = false`)
	}
}
func TestCanalPalindrome(t *testing.T) {
	input := "A man, a plan, a canal: Panama"
	if !IsPalindrome(input) {
		t.Errorf(`IsPalindrome(%q) = false`, input)
	}
}
