import 'package:iris_tools/api/generator.dart';

import 'package:app/structures/models/mediaModel.dart';

class ConsultantForMeetingModel {
  String id = '';
  String name = '';
  MediaModel? avatar;
  String positionTitle = '';

  ConsultantForMeetingModel() : id = Generator.generateName(10);

  ConsultantForMeetingModel.fromMap(Map map) {
    id = map['id'];
    name = map['name']?? '';
    positionTitle = map['positionTitle']?? '';

    if(map['avatar'] is Map) {
      avatar = MediaModel.fromMap(map['avatar']);
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['name'] = name;
    map['positionTitle'] = positionTitle;
    map['avatar'] = avatar?.toMap();

    return map;
  }
}
