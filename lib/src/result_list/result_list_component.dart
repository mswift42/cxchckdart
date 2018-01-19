import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'resut-list',
  styleUrls: const ['result_list_component.css'],
  templateUrl: 'result_list_component.html',
  directives: const [
    materialDirectives,
  ],
)
class ResultListComponent {
  String title;
  String price;
  String thumbnail;
  String description;

}