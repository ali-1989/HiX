import 'package:iris_tools/dateSection/dateHelper.dart';

class NotificationModel {
  String description = '';
  late DateTime date;
  bool isSeen = false;

  NotificationModel();

  NotificationModel.fromMap(Map map) {
    description = map['description']?? '';
    isSeen = map['isSeen']?? false;
    date = DateHelper.tsToSystemDate(map['date'])!;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['description'] = description;
    map['isSeen'] = isSeen;
    map['date'] = date;

    return map;
  }
}
