/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-13
 * Time: 下午11:40
 */

package tempconv

import "fmt"

type Celsius float64
type Fahrenheit float64

func CToF(c Celsius) Fahrenheit {

}

type celsiusFlag struct {
	Celsius
}

func (f *celsiusFlag) Set(s string) error {
	var unit string
	var value float64
	fmt.Sscanf(s, "%f%s", &value, &unit)

	switch unit {
	case "C":
		f.Celsius = Celsius(value)
		return nil
	case "F":
		f.Celsius = FToC()
		return nil
	}

	return fmt.Errorf("invalid temprature %q", s)
}
