/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-08
 * Time: 下午10:23
 */

package main

import "os"

//捕获迭代变量

func main() {

	var rmdirs []func()

	for _, d := range tempDirs() {
		dir := d //这一步是必须的, 因为: 在上面的程序中,for循环语句引入了新的词法块,循环
		//变量dir在这个词法块中被声明。在该循环中生成的所有函数值都共享相同的循环变量。需要
		//注意,函数值中记录的是循环变量的内存地址,而不是循环变量某一时刻的值。以dir为例,
		//	后续的迭代会不断更新dir的值,当删除操作执行时,for循环已完成,dir中存储的值等于最后
		//一次迭代的值。
		os.MkdirAll(dir, 0755)
		rmdirs = append(rmdirs, func() {
			os.RemoveAll(dir)
		})
	}

	for _, dir := range tempDirs() {
		os.MkdirAll(dir, 0755)
		rmdirs = append(rmdirs, func() {
			os.RemoveAll(dir)
		})
	}

	//下面这种 也会报错

	var rmdirs []func()
	dirs := tempDirs()
	for i := 0; i < len(dirs); i++ {
		os.MkdirAll(dirs[i], 0755) // OK
		rmdirs = append(rmdirs, func() {
			os.RemoveAll(dirs[i]) // NOTE: incorrect!
		})
	}

}
