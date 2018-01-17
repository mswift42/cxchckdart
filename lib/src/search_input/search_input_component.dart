import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../cx_service.dart';

@Component(
  selector: 'search-input',
  styleUrls: const ['search_input_component.css'],
  templateUrl: 'search_input_component.html',
  directives: const [
    materialDirectives,
    CORE_DIRECTIVES,
  ],
  providers: const [CxService],
)
class SearchInputComponent {
  String newQuery = '';
  final CxService _cxService;

  List<Store> storeValues = const [
    const Store("Rose, Street", "54"),
    const Store("Cameron Toll", "3017")
  ];

  SearchInputComponent(this._cxService);

  void add() {
    print(newQuery);
    print(_cxService.queryUrl(newQuery, "54"));
    newQuery = '';
  }
}

class Store {
  final String location;
  final String identifier;

  const Store(this.location, this.identifier);
}
