
enum ConsultantMeetingStatus {
  unKnow(-1),
  reserved(1),
  cancel(2),
  did(3);

  final int _number;

  const ConsultantMeetingStatus(this._number);

  int getNumber(){
    return _number;
  }

  factory ConsultantMeetingStatus.from(dynamic numberOrString){
    if(numberOrString is String){
      return values.firstWhere((element) => element.name == numberOrString, orElse: ()=> unKnow);
    }

    if(numberOrString is int){
      return values.firstWhere((element) => element._number == numberOrString, orElse: ()=> unKnow);
    }

    return ConsultantMeetingStatus.unKnow;
  }

  String getHumanMessage(){
    switch(_number){
      case 1:
        return 'رزرو شده';
      case 2:
        return 'لغو شده';
      case 3:
        return 'انجام شده';
    }

    return 'نامشخص';
  }
}
