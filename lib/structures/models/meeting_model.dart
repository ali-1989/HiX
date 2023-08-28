import 'package:app/structures/enums/consultant_meeting_status.dart';
import 'package:app/structures/models/consultant_for_meeting_model.dart';

class MeetingModel {
  String id = '';
  String title = '';
  late ConsultantForMeetingModel consultant;
  late ConsultantMeetingStatus status;
  late DateTime date;

  MeetingModel();

  MeetingModel.fromMap(Map map) {
    id = map['id'];
    title = map['title']?? '';
    status = ConsultantMeetingStatus.from(map['status']);
    date = map['date']?? false;
    consultant = ConsultantForMeetingModel.fromMap(map['consultant']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['title'] = title;
    map['status'] = status.getNumber();
    map['date'] = date;
    map['consultant'] = consultant.toMap();

    return map;
  }
}