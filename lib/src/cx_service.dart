import 'package:angular/angular.dart' show Injectable;
import 'package:http/http.dart' as http;
import 'dart:html';
import 'dart:async';
import 'dart:convert';


@Injectable()
class CxService {
  List<Product> results = [];

  Future<List<Product>> queryUrl(String query, String location) async {
    var response = await HttpRequest.getString(
        'http://localhost:4242/querycx?query=${query}&location=${location}');
    var decoded = JSON.decode(response);
    return decoded?.map((i) => new Product(i["Title"],
            "https://uk.webuy.com" + i["Thumbnail"],
            i["Price"], i["Description"]));
  }
}
