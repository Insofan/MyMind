//
//  default.go
//  GoInAction 
//
//  Created by Inso on 2018/9/14.
//  Copyright © 2018 Inso. All rights reserved.
//
package search

//默认matcher
type defaultMatcher struct {}


func init() {
	var matcher defaultMatcher

}

func (m defaultMatcher) Search(feed *Feed, searchTerm string) ([]) {

}
