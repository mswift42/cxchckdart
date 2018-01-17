import 'package:angular/angular.dart' show Injectable;
import 'package:http/http.dart' as http;
import 'dart:html';
import 'dart:async';

@Injectable()
class CxService {


  Future<String> queryUrl(String query, String location) async {
    var response = await HttpRequest.getString('http://localhost:4242/querycx?query=${query}&location=${location}');
    print(response);
    return response;
  }
  
  


}

