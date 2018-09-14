//
//  match.go
//  GoInAction
//
//  Created by Inso on 2018/9/14.
//  Copyright © 2018 Inso. All rights reserved.
//

package search

import "log"

type Result struct {
	Field   string
	Content string
}

//定义接口, 和必须实现的函数
type Matcher interface {
	Search(feed *Feed, searchTerm string) ([]*Result, error)
}

/**
根据数据源, 为每个数据源单独启动 goroutine 来执行这个函数
注意传出通道写法
*/
func Match(matcher Matcher, feed *Feed, searchTerm string, results chan<- *Result) {
	//对特定匹配器执行搜索
	searchResults, err := matcher.Search(feed, searchTerm)
	if err != nil {
		log.Println(err)
		return
	}
	for _, result := range searchResults {
		//将结果写入通道
		results <- result
	}
}

//接收通道
func Display(results chan *Result) {
	for result := range results {
		log.Printf("%s:\n%s\n\n", result.Field, result.Content)
	}
}
