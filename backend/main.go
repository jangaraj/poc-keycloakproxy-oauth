package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
	"os"
	"sort"
        "time"
)

func main() {

	name, _ := os.Hostname()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
                fmt.Fprintf(w, "Timestamp: %q\n", time.Now().Format(time.RFC850))
		fmt.Fprintf(w, "Hostname: %q\n\n", html.EscapeString(name))
		keys := make([]string, len(r.Header))
		i := 0
		for k, _ := range r.Header {
			keys[i] = k
			i++
		}
		sort.Strings(keys)
		for _, k := range keys {
			for _, h := range r.Header[k] {
				fmt.Fprintf(w, "%v: %v\n", k, h)
			}

		}

	})

	log.Fatal(http.ListenAndServe(":8081", nil))

}
