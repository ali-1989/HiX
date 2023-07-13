import 'package:iris_tools/api/generator.dart';

class DashboardNavigateModel {
  String id = '';
  String title = '';
  String iconAddress = '';
  bool isSelected = false;

  DashboardNavigateModel() : id = Generator.generateName(10);

  DashboardNavigateModel.fromMap(Map map) {
    title = map['title']?? '';
    id = map['id'];
    iconAddress = map['iconAddress']?? '';
    isSelected = map['isSelected']?? false;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['title'] = title;
    map['iconAddress'] = iconAddress;
    map['isSelected'] = isSelected;

    return map;
  }
}
