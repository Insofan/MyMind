/**
 * Created with Goland.
 * Description:
 * User: Insomnia
 * Date: 2018-09-28
 * Time: 下午6:03
 */

package main

import (
	"bufio"
	"fmt"
	"log"
	"net"
)

type client chan<- string

var (
	entering = make(chan client)
	leaving  = make(chan client)
	messages = make(chan string) //all incoming client messages
)

func broadcaster() {
	clients := make(map[client]bool) // all connected clients, 记录了所有的client
	for {
		select {
		case msg := <-messages:
			//Boradcast incoming message to all
			for cli := range clients {
				cli <- msg
			}
		case cli := <-entering:
			clients[cli] = true
		case cli := <-leaving:
			delete(clients, cli)
			close(cli)
		}
	}
}

func clientWriter(conn net.Conn, ch <-chan string) {
	for msg := range ch {
		fmt.Fprintln(conn, msg)
	}
}

func handleConn(conn net.Conn) {
	ch := make(chan string)
	go clientWriter(conn, ch)

	who := conn.RemoteAddr().String()
	ch <- "You are " + who
	messages <- who + " has arrived"
	entering <- ch

	input := bufio.NewScanner(conn)
	for input.Scan() {
		messages <- who + ": " + input.Text()
	}

	leaving <- ch
	messages <- who + " has left"
	conn.Close()
}

//用netcat3 来跑clinet
func main() {
	listener, err := net.Listen("tcp", ":8000")
	if err != nil {
		log.Fatal()
	}

	go broadcaster()

	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Print(err)
			continue
		}

		go handleConn(conn)
	}
}
