package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from the Go Server! You reached us via %s\n", r.RemoteAddr)
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Server is staring on port 8080...")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
