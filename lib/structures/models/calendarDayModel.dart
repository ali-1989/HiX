

class CalendarDayModel {
  String number = '1';
  bool hasSupportTime = false;

  CalendarDayModel();

  CalendarDayModel.fromMap(Map? map){
    if(map == null){
      return;
    }

    number = map['number'];
    hasSupportTime = map['hasSupportTime']?? false;

  }

  Map<String, dynamic> toMap(){
    final map = <String, dynamic>{};

    map['number'] = number;
    map['hasSupportTime'] = hasSupportTime;

    return map;
  }
}
