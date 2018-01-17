package cxcecker

import (
	"fmt"
	"io/ioutil"
	"net/http"

	"google.golang.org/appengine"
	"google.golang.org/appengine/urlfetch"
)

func init() {
	http.HandleFunc("/querycx", getResults)
}

func getResults(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "text/html;charset=utf8")
	// w.Header().Set("Access-Control-Allow-Origin", "*")
	query := r.FormValue("query")
	location := r.FormValue("location")
	url := "https://uk.webuy.com/search/index.php?stext=" + query + "&section=&rad_which_stock=3&refinebystore=" +
		location
	ctx := appengine.NewContext(r)
	client := urlfetch.Client(ctx)
	results, err := client.Get(url)
	if err != nil {
		fmt.Fprintf(w, err.Error(), http.StatusInternalServerError)
	}
	body, err := ioutil.ReadAll(results.Body)
	if err != nil {
		http.Error(w, "couldn't get response body", http.StatusInternalServerError)
	}
	fmt.Fprintf(w, string(body))
}
