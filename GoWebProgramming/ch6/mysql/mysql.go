/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-03
 * Time: 下午8:57
 */

package main

import (
	"fmt"
	"log"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mssql"
)

type Post struct {
	ID      int `gorm:"primary_key"`
	Content string
	Author  string `sql:"not null"`
	//Comments   []Comment
	CreateTime time.Time
}

type Comment struct {
	ID          int `gorm:"primary_key"`
	Content     string
	Author      string `sql:"not null"`
	PostId      int
	CreatedTime time.Time
}

var Db *gorm.DB

func init() {
	var err error
	Db, err = gorm.Open("mysql", "root:admin@tcp(localhost:3306)/gwp?charset=utf8&parseTime=true&loc=Local")
	if err != nil {
		//panic("连接数据库失败")
		panic(err)
	}
}

func main() {
	/*
		这部分关联有问题
		comment := Comment{ID: 1, Content: "Good post!", Author: "Joe", PostId: 1}
		if err := Db.Model(&post).Related(&comment).Error; err != nil {
			log.Fatalln(err)
		}
		//db.Model(&user).Association("Languages").Append(Language{Name: "DE"})

		if err := Db.CreateTable(&Post{}).Error; err != nil {
			fmt.Println(err)
		}
		if err := Db.Create(&post).Error; err != nil {
			log.Fatal(err)
		}
	*/

	/*
		var comments []Comment
		Db.Model(&readPost).Related(&comments)
		fmt.Println(comments)
	*/

	/*
		Create
	*/

	//创建表	Db.CreateTable(&Post{})
	Db.CreateTable(&Post{})

	//插入model
	post := Post{Content: "Hello World!", Author: "Insomnia", CreateTime: time.Now()}
	Db.Create(&post)

	/*
		Read
	*/

	var readPost Post
	Db.Where("author = ?", "Insomnia").First(&readPost)
	fmt.Println(readPost)

	/*
		Update
	*/
	var readPost2 Post
	if err := Db.Model(&readPost).Where("id = ?", 1).Update("Content", "你好世界!").Error; err != nil {
		log.Fatalln(err)
	}
	Db.Where("id = 1").First(&readPost2)
	fmt.Println(readPost)

	/*
		Delete:
		注意gorm 有一个soft delete: If model has DeletedAt field, it will get soft delete ability automatically! then it won't be deleted from database permanently when call Delete, but only set field DeletedAt's value to current time
		只要有DeletedAt, 或者使用了它的gorm.Model就会soft delete
	*/
	Db.Where("author = ?", "Insomnia").Delete(&Post{})
}
