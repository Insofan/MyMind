/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-07
 * Time: 上午1:05
 */

package main

import (
	"../github"
	"html/template"
	"log"
	"os"
)

var issuesList = template.Must(template.New("issuelist").Parse(
	`
		<h1>{{.TotalCount}} issues </h1>
		<table>
		<tr style='text-align: left'>
			<th>#</th>
			<th>State</th>
			<th>User</th>
			<th>Title</th>
		</tr>
		{{range .Items}}
		<tr>
			<td><a href='{{.HTMLURL}}'>{{.Number}}</td>
			<td>{{.State}}</td>
			<td><a href='{{.User.HTMLURL}}'>{{.User.Login}}</a></td>
			<td><a href='{{.HTMLURL}}'>{{.Title}}</a></td>
		</tr>
		{{end}}
		</table>
`))

func main() {
	// ./issuesreport repo:golang/go is:open json decoder > issuesreport.html
	result, err := github.SearchIssues(os.Args[1:])

	if err != nil {
		log.Fatal(err)
	}

	if err := issuesList.Execute(os.Stdout, result); err != nil {
		log.Fatal(err)
	}
}
