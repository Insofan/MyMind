/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-02
 * Time: 下午1:58
 */

package tempconv0

func CToF(c Celsius) Fahrenheit {
	return Fahrenheit(c*9/5 + 32)
}

func FToC(f Fahrenheit) Celsius {
	return Celsius((f - 32) * 5 / 9)
}
