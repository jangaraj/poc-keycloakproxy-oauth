package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
	"os"
	"sort"
	"time"
        "io/ioutil"
	"crypto/tls"
        "crypto/x509"
)

func main() {

	name, _ := os.Hostname()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Timestamp: %q\n", time.Now().Format(time.RFC850))
		fmt.Fprintf(w, "Hostname: %q\n", html.EscapeString(name))
                fmt.Fprintf(w, "TLS cert: %v!\n\n", r.TLS.PeerCertificates[0].EmailAddresses[0])

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

	//log.Fatal(http.ListenAndServe(":8081", nil))

	certBytes, err := ioutil.ReadFile("servercert.pem")
	if err != nil {
		log.Fatalln("Unable to read cert.pem", err)
	}

	clientCertPool := x509.NewCertPool()
	if ok := clientCertPool.AppendCertsFromPEM(certBytes); !ok {
		log.Fatalln("Unable to add certificate to certificate pool")
        }
	tlsConfig := &tls.Config{
		// Reject any TLS certificate that cannot be validated
		ClientAuth: tls.RequireAndVerifyClientCert,
		// Ensure that we only use our "CA" to validate certificates
		ClientCAs: clientCertPool,
		// PFS because we can but this will reject client with RSA certificates
                CipherSuites: []uint16{tls.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
                                       tls.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256},
		// Force it server side
		PreferServerCipherSuites: true,
		// TLS 1.2 because we can
		MinVersion: tls.VersionTLS12,
	}
	tlsConfig.BuildNameToCertificate()
	httpServer := &http.Server{
		Addr:      ":8082",
		TLSConfig: tlsConfig,
	}
	log.Fatal(httpServer.ListenAndServeTLS("servercert.pem", "serverkey.pem"))

}
