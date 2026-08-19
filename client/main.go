package main

import (
	"fmt"
	"io"
	"net/http"
	"time"
)

func main() {
	time.Sleep(3 * time.Second)

	for {
		resp, err := http.Get("http://go-server:8080")
		if err != nil {
			fmt.Printf("Client error: %v\n", err)
		} else {
			body, _ := io.ReadAll(resp.Body)
			fmt.Printf("Received from server: %s\n", string(body))
			resp.Body.Close()
		}

		time.Sleep(5 * time.Second)
	}
}
