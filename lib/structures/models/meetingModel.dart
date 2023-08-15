import 'package:iris_tools/api/generator.dart';

class MeetingModel {
  String id = '';
  String title = '';
  late ConsultantMeetingModel consultant;
  late int state;
  late DateTime date;

  MeetingModel();

  MeetingModel.fromMap(Map map) {
    id = map['id'];
    title = map['title']?? '';
    state = map['state']?? '';
    date = map['date']?? false;
    consultant = ConsultantMeetingModel.fromMap(map['consultant']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['title'] = title;
    map['state'] = state;
    map['date'] = date;
    map['consultant'] = consultant.toMap();

    return map;
  }
}
///=============================================================
class ConsultantMeetingModel {
  String id = '';
  String name = '';
  String positionTitle = '';

  ConsultantMeetingModel() : id = Generator.generateName(10);

  ConsultantMeetingModel.fromMap(Map map) {
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