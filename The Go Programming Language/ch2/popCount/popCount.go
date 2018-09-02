/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-02
 * Time: 下午2:22
 */

package popCount

var pc [256]byte

//pc[i] is the population count of i
func init() {
	for i := range pc {
		pc[i] = pc[i/2] + byte(i&1)
	}
}

//PopCount returns the popution count (number of set bits) of x

func PopCount(x uint64) int {
	return int(pc[byte(x>>(0*8))] +
		pc[byte(x>>(1*8))] +
		pc[byte(x>>(2*8))] +
		pc[byte(x>>(3*8))] +
		pc[byte(x>>(4*8))] +
		pc[byte(x>>(5*8))] +
		pc[byte(x>>(6*8))] +
		pc[byte(x>>(7*8))])

}
