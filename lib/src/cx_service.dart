import 'package:angular/angular.dart' show Injectable;
import 'package:http/http.dart' as http;
import 'dart:html';

@Injectable()
class CxService {
  String query;
  String location;

  CxService(this.query, this.location);

  String queryUrl() {
    return 'https://uk.webuy.com/search/index.php?stext=${query}section=&rad_which_stock=3&refinebystore=${location}';
  }
}

