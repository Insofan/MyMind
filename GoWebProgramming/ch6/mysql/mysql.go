/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-03
 * Time: 下午8:57
 */

package main

import (
	_ "github.com/go-sql-driver/mysql"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mssql"
)

func main() {
	//       db, err := gorm.Open("mysql", "user:password@/dbname?charset=utf8&parseTime=True&loc=Local")
	db, err := gorm.Open("mysql", "root:admin@tcp(localhost:3306)/gwp?charset=utf8&parseTime=true&loc=Local")
	if err != nil {
		//panic("连接数据库失败")
		panic(err)
	}

	defer db.Close()

}
