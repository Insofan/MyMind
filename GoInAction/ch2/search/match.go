//
//  match.go
//  GoInAction 
//
//  Created by Inso on 2018/9/14.
//  Copyright © 2018 Inso. All rights reserved.
//
package search


type Result struct {
	Field string
	Content string
}

type Matcher struct {
	Search(feed *Feed)
}