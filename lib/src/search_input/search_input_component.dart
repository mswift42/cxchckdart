import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'dart:async';

import '../cx_service.dart';
import '../product.dart' show Product;

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
class SearchInputComponent implements OnInit {
  String newQuery = '';
  final CxService _cxService;
  List<Product> results = [];
  bool noResults = false;

  List<Store> storeOptions = const [
    const Store("Rose, Street", "54"),
    const Store("Cameron Toll", "3017")
  ];

  Store activeStore;

  @override
  ngOnInit() {
   activeStore = storeOptions[0];
   results = [];
   noResults = false;
  }


  SearchInputComponent(this._cxService);

  Future<Null> add() async {
    print(newQuery);
    List<Product> jres = await _cxService.queryUrl(newQuery, activeStore.identifier);
    results = jres;
    if (results.length == 0) {
      noResults = true;
    }
  }

  Future<Null> searchButtonClick() async {
    results = [];
    add();
  }
}


class Store {
  final String location;
  final String identifier;

  const Store(this.location, this.identifier);
}
