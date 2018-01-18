package cxcecker

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

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

func parseResults(doc *goquery.Document) []*QueryResult {
	var results []*QueryResult
	doc.Find(".searchRecord").Each(func(i int, s *goquery.Selection) {
		title := s.Find("img").AttrOr("alt", "")
		thumb := s.Find("img").AttrOr("src", "")
		price := strings.Replace(s.Find("div.priceTxt").First().Text(), "WeSell for", "", -1)
		res := &QueryResult{title, thumb, price, ""}
		fmt.Println(price)
		fmt.Println(res)
		results = append(results, res)
	})
	return results
}

type QueryResult struct {
	Title       string `json:title`
	Thumbnail   string `json:thumb`
	Price       string `json:price`
	Description string `json:description`
}

func (q *QueryResult) String() string {
	return fmt.Sprintf("%s\n%s\n%s\n%s", q.Title, q.Thumbnail, q.Price, q.Description)
}

func getResults(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content-Type", "text/html;charset=utf8")
	w.Header().Set("Access-Control-Allow-Origin", "*")
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
	json.NewEncoder(w).Encode(res)
}
