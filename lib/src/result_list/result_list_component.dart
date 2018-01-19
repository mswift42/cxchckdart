import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../product.dart' show Product;

@Component(
  selector: 'resut-list',
  styleUrls: const ['result_list_component.css'],
  templateUrl: 'result_list_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
)
class ResultListComponent {
  @Input() Product product;
}