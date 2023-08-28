import 'package:iris_tools/api/generator.dart';

class ConsultantForMeetingModel {
  String id = '';
  String name = '';
  String positionTitle = '';

  ConsultantForMeetingModel() : id = Generator.generateName(10);

  ConsultantForMeetingModel.fromMap(Map map) {
    id = map['id'];
    name = map['name']?? '';
    positionTitle = map['positionTitle']?? '';
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['name'] = name;
    map['positionTitle'] = positionTitle;

    return map;
  }
}