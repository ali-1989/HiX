import 'package:iris_tools/dateSection/dateHelper.dart';

class ConsultantCommentModel {
  String id = '';
  late SenderUser senderUser;
  String text = '';
  double? rate;
  late DateTime date;
  List<ConsultantCommentModel> replyList = [];

  ConsultantCommentModel();

  ConsultantCommentModel.fromMap(Map map) {
    id = map['id'];
    text = map['text']?? '';
    rate = map['rate'];
    date = DateHelper.tsToSystemDate(map['date'])!;
    senderUser = SenderUser.fromMap(map['consultant']);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['text'] = text;
    map['rate'] = rate;
    map['date'] = DateHelper.toTimestampNullable(date);
    map['senderUser'] = senderUser.toMap();

    return map;
  }
}

class SenderUser {
  late String id;
  late String name;
  UserRole userRole = UserRole.unKnow;

  SenderUser();

  SenderUser.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    userRole = UserRole.from(map['userRole']);
  }

  Map<String, dynamic> toMap(){
    final map = <String, dynamic>{};

    map['id'] = id;
    map['name'] = name;
    map['userRole'] = userRole.number;

    return map;
  }
}

enum UserRole {
  unKnow(-1),
  admin(1),
  consultant(2),
  user(3);

  final int number;

  const UserRole(this.number);

  factory UserRole.from(dynamic numberOrString){
    if(numberOrString is String){
      return values.firstWhere((element) => element.name == numberOrString, orElse: ()=> unKnow);
    }

    if(numberOrString is int){
      return values.firstWhere((element) => element.number == numberOrString, orElse: ()=> unKnow);
    }

    return UserRole.unKnow;
  }
}