import 'package:iris_tools/dateSection/dateHelper.dart';

class NotificationModel {
  String title = '';
  String description = '';
  late DateTime date;
  bool isSeen = false;

  NotificationModel();

  NotificationModel.fromMap(Map map) {
    title = map['title']?? '';
    description = map['description']?? '';
    isSeen = map['isSeen']?? false;
    date = DateHelper.tsToSystemDate(map['date'])!;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['title'] = title;
    map['description'] = description;
    map['isSeen'] = isSeen;
    map['date'] = date;

    return map;
  }
}
