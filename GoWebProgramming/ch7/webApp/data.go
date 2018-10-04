/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-04
 * Time: 下午1:20
 */

package main

import (
	"fmt"
	"log"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

var Db *gorm.DB

func init() {
	var err error
	Db, err = gorm.Open("mysql", "root:admin@tcp(localhost:3306)/gwp?charset=utf8&parseTime=true&loc=Local")
	if err != nil {
		log.Fatal(err)
	}
}

func retrieve(id int) (post Post, err error) {
	post = Post{}
	err = Db.Where("id = ?", id).First(&post).Error
	return

}

func (p *Post) create() (err error) {
	if err := Db.CreateTable(&Post{}).Error; err != nil {
		fmt.Println(err)
	}
	//Db.CreateTable(&Post{})
	if err := Db.Exec("INSERT INTO posts (created_at,content, author) values (?,?, ?)", time.Now(), p.Content,
		p.Author).Error; err != nil {
		log.Fatal(err)
	}
	return
}

func (p *Post) update() (err error) {
	p.UpdatedAt = time.Now()
	if err := Db.Model(&p).Where("id = ?", p.ID).Save(&p).Error; err != nil {
		fmt.Println(err)
	}

	return
}

func (p *Post) delete() (err error) {
	if err := Db.Where("id = ?", p.ID).Delete(&Post{}).Error; err != nil {
		fmt.Println(err)
	}
	return

}
