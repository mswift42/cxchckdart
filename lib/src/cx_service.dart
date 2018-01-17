import 'package:angular/angular.dart' show Injectable;
import 'package:http/http.dart' as http;
import 'dart:html';
import 'dart:async';

@Injectable()
class CxService {


  String queryUrl(String query, String location) {
    return 'https://uk.webuy.com/search/index.php?stext=${query}&section=&rad_which_stock=3&refinebystore=${location}';
  }



}

