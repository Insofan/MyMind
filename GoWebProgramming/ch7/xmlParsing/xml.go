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
	"io"
	"os"
)

type Post struct {
	//attr 存属性值, chardata 存字符数据, innerxml 存原始xml, 没有标识的将同名匹配
	XMLName xml.Name `xml:"post"`
	Id      string   `xml:"id,attr"`
	Content string   `xml:"content"`
	Author  Author   `xml:"author"`
	Xml     string   `xml:",innerxml"`
	//跳跃式访问
	Comments []Comment `xml:comments>comment`
}

type Author struct {
	Id   string `xml:"id,attr"`
	Name string `xml:",chardata"`
}

type Comment struct {
	Id      string `xml:"id,attr"`
	Content string `xml:"content"`
	Author  Author `xml:"author"`
}

func main() {
	xmlFile, err := os.Open("ch7/xmlParsing/post.xml")
	if err != nil {
		fmt.Println("Err open xml file :", err)
		return
	}

	defer xmlFile.Close()

	decoder := xml.NewDecoder(xmlFile)

	for {
		t, err := decoder.Token()
		if err == io.EOF {
			break
		}

		if err != nil {
			fmt.Println("Err reading xml data:", err)
			return
		}

		switch se := t.(type) {
		case xml.StartElement:
			if se.Name.Local == "comment" {
				var comment Comment
				decoder.DecodeElement(&comment, &se)
				fmt.Println(comment)
			}
		}
	}

}
