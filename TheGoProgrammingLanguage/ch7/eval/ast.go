/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-16
 * Time: 下午7:25
 */

package eval

type Expr interface {
	Eval(env Env) float64
}

type Var string
type literal float64

type unary struct {
	op rune
	x  Expr
}

type binary struct {
	op   rune
	x, y Expr
}

type call struct {
	fn   string
	args []Expr
}
