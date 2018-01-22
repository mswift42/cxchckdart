import 'package:angular/angular.dart' show Injectable;
import 'package:http/http.dart' as http;
import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'product.dart' show Product;


@Injectable()
class CxService {
  List<Product> results = [];

  Future<List<Product>> queryUrl(String query, String location) async {
    var trimmed = query.trim().replaceAll(new RegExp(r' '), ",");
    var response = await HttpRequest.getString(
        //'http://localhost:4242/querycx?query=${trimmed}&location=${location}');
        '/querycx?query=${trimmed}&location=${location}');
    var decoded = JSON.decode(response);
    return decoded?.map((i) => new Product(i["Title"],
            "https://uk.webuy.com" + i["Thumbnail"],
            i["Price"], i["Description"],
        "https://uk.webuy.com" + i["URL"]));
  }
}
