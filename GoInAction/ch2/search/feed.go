//
//  feed.go
//  GoInAction
//
//  Created by Inso on 2018/9/14.
//  Copyright © 2018 Inso. All rights reserved.
//
package search

import (
	"encoding/json"
	"os"
)

//const dataFile = "/Users/inso/Desktop/Go/src/MyMind/GoInAction/ch2/data/data.json"
const dataFile = "ch2/data/data.json"

type Feed struct {
	Name string `json:"site"`
	URI  string `json:"link"`
	Type string `json:"type"`
}

func RetrieveFeeds() ([]*Feed, error) {
	file, err := os.Open(dataFile)
	if err != nil {
		return nil, err
	}
	//析构 打开后跟一个defer, 函数返回时才会执行
	defer file.Close()

	//decode 成一个指针切片
	var feeds []*Feed

	err = json.NewDecoder(file).Decode(&feeds)
	//if err != nil {
	//	return nil, err
	//}

	//这里不需要检查错误, 因为这个err 会被返回, 调用者会检查

	return feeds, err
}
