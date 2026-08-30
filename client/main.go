package main

import (
	"fmt"
	"io"
	"net/http"
	"time"
)

func main() {
	time.Sleep(3 * time.Second)

	fmt.Println("Secure OS-Trusted CLient loop starting...")
	for {
		resp, err := http.Get("https://go-server:443")
		if err != nil {
			fmt.Printf("Client error: %v\n", err)
		} else {
			body, _ := io.ReadAll(resp.Body)
			fmt.Printf("OS-Trusted Secure payload: %s\n", string(body))
			resp.Body.Close()
		}

		time.Sleep(5 * time.Second)
	}
}
