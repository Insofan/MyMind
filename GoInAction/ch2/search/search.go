//
//  search.go
//  GoInAction
//
//  Created by Inso on 2018/9/13.
//  Copyright © 2018 Inso. All rights reserved.
//
package search

import (
	"log"
	"sync"
)

// A map of registered matchers for searching.
var matchers = make(map[string]Matcher)

func Run(searchTerm string) {
	feeds, err := RetrieveFeeds()

	//刚才retrieve的err在这里检查了
	if err != nil {
		log.Fatalln(err)
	}

	//创建一个 channel 接受结果
	results := make(chan *Result)

	var waitGroup sync.WaitGroup
	//根据返回的切片feeds长度来决定 数量
	waitGroup.Add(len(feeds))

	for _, feed := range feeds {
		//每一个feed, 这里map 有一个 exists的值可以检查是否存在
		matcher, exists := matchers[feed.Type]
		if !exists {
			//没有时用default.go里面的
			matcher = matchers["default"]
		}

		//开groutine
		go func(matcher Matcher, feed *Feed) {
			Match(matcher, feed, searchTerm, results)
			waitGroup.Done()
		}(matcher, feed)
	}

	//整个 groutine 的过程和 等待过程 非常值得研究
	go func() {
		//等待 group 运行
		waitGroup.Wait()

		// Close the channel to signal to the Display
		// function that we can exit the program.
		close(results)
	}()

	//显示
	Display(results)
}

func Register(feedType string, matcher Matcher) {
	if _, exists := matchers[feedType]; exists {
		log.Fatalln("Matcher already registed")
	}

	log.Println("Register", feedType, "matcher")
	matchers[feedType] = matcher
}
