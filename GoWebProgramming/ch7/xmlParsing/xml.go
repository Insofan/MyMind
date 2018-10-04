/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-10-04
 * Time: 上午10:59
 */

package main

import (
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"os"
)

type Post struct {
	//attr 存属性值, chardata 存字符数据, innerxml 存原始xml, 没有标识的将同名匹配
	XMLName xml.Name `xml:"post"`
	Id      string   `xml:"id,attr"`
	Content string   `xml:"content"`
	Author  Author   `xml:"author"`
	Xml     string   `xml:",innerxml"`
}

type Author struct {
	Id   string `xml:"id, attr"`
	Name string `xml:",chardata"`
}

func main() {
	xmlFile, err := os.Open("ch7/xmlParsing/post.xml")
	if err != nil {
		fmt.Println("Err open xml file :", err)
		return
	}

	defer xmlFile.Close()
	xmlData, err := ioutil.ReadAll(xmlFile)
	if err != nil {
		fmt.Println("Err reading xml data:", err)
		return
	}

	var post Post
	xml.Unmarshal(xmlData, &post)
	fmt.Println(post)

}
