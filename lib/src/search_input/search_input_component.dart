import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'search-input',
    styleUrls: const ['search_input_component.css'],
  templateUrl: 'search_input_component.html',
  directives: const [
    materialDirectives
  ]
)
class SearchInputComponent {
  String newQuery = '';

  void add() {
    print(newQuery);
    newQuery = '';
  }
}
