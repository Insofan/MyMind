/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-13
 * Time: 下午11:40
 */

package tempconv

import (
	"flag"
	"fmt"
)

type Celsius float64
type Fahrenheit float64

func CToF(c Celsius) Fahrenheit {
	return Fahrenheit(c*9.0/5.0 + 32.0)
}

func FToC(f Fahrenheit) Celsius {
	return Celsius((f - 32.0) * 5.0 / 9.0)
}

func (c Celsius) String() string {
	return fmt.Sprintf("%g", c)
}

type celsiusFlag struct {
	Celsius
}

//这个是celsiusFlag默认set
func (f *celsiusFlag) Set(s string) error {
	var unit string
	var value float64
	fmt.Sscanf(s, "%f%s", &value, &unit)

	switch unit {
	case "C", "c":
		f.Celsius = Celsius(value)
		return nil
	case "F", "f":
		f.Celsius = FToC(Fahrenheit(value))
		return nil
	}

	return fmt.Errorf("invalid temprature %q", s)
}

func CelsiusFlag(name string, value Celsius, usage string) *Celsius {
	f := celsiusFlag{value}
	flag.CommandLine.Var(&f, name, usage)
	return &f.Celsius
}
