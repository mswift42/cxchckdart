package cxcecker

import (
	"fmt"
	"net/http"

	"github.com/PuerkitoBio/goquery"
	"google.golang.org/appengine"
	"google.golang.org/appengine/urlfetch"
)

func init() {
	http.HandleFunc("/querycx", getResults)
}

func newCxDocument(resp *http.Response) (*goquery.Document, error) {
	doc, err := goquery.NewDocumentFromResponse(resp)
	if err != nil {
		return nil, err
	}
	return doc, nil
}

func parseResults(doc *goquery.Document) []string {
	var results []string
	doc.Find(".searchRecord img").Each(func(i int, s *goquery.Selection) {
		results = append(results, s.AttrOr("alt", "no luck"))
	})
	return results
}

type queryResult struct {
	title       string
	thumbnail   string
	price       string
	description string
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
	doc, err := newCxDocument(results)
	if err != nil {
		fmt.Fprintf(w, err.Error(), http.StatusInternalServerError)
	}
	res := parseResults(doc)
	fmt.Fprintf(w, "%v", res)
}
