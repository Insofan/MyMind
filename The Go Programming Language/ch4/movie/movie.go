/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-06
 * Time: 上午12:17
 */

package main

import (
	"encoding/json"
	"fmt"
	"log"
)

type Movie struct {
	Title string
	Year  int `json:"released"`
	//omitempty 表示空值时 不产生对象
	Color  bool `json:"color, omitempty"`
	Actors []string
}

var movie = []Movie{
	{Title: "Casablanca", Year: 1942, Color: false,
		Actors: []string{"Humphrey Bogart", "Ingrid Bergman"}},
	{Title: "Cool Hand Luke", Year: 1967, Color: true,
		Actors: []string{"Paul Newman"}},
	{Title: "Bullitt", Year: 1968, Color: true,
		Actors: []string{"Steve McQueen", "Jacqueline Bisset"}},
	// ...
}

func main() {
	//data, err := json.Marshal(movie)
	data, err := json.MarshalIndent(movie, "", "\t")
	if err != nil {
		log.Fatalf("JSON marshaling failed: %s", err)
	}
	fmt.Printf("%s\n", data)
}
