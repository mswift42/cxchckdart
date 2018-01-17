import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../cx_service.dart';

@Component(
  selector: 'search-input',
    styleUrls: const ['search_input_component.css'],
  templateUrl: 'search_input_component.html',
  directives: const [
    materialDirectives
  ],
  providers: const [CxService],

)
class SearchInputComponent {
  String newQuery = '';
  final CxService _cxService;

  SearchInputComponent(this._cxService);

  void add() {
    print(newQuery);
    print(_cxService.queryUrl(newQuery, "54"));
    newQuery = '';
  }
}
