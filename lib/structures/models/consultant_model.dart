import 'package:iris_tools/api/generator.dart';

import 'package:app/structures/models/mediaModel.dart';

class ConsultantModel {
  String id = '';
  String name = '';
  String doctorNumber = '';
  int countOfConsultation = 0;
  double rate = 0;
  bool isBookmark = false;
  MediaModel? avatar;
  String positionTitle = '';

  ConsultantModel() : id = Generator.generateName(10);

  ConsultantModel.fromMap(Map map) {
    id = map['id'];
    name = map['name']?? '';
    doctorNumber = map['doctorNumber']?? '';
    positionTitle = map['positionTitle']?? '';
    countOfConsultation = map['countOfConsultation']?? 0;
    isBookmark = map['isBookmark']?? false;
    rate = map['rate']?? 0;

    if(map['avatar'] is Map) {
      avatar = MediaModel.fromMap(map['avatar']);
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['name'] = name;
    map['positionTitle'] = positionTitle;
    map['doctorNumber'] = doctorNumber;
    map['countOfConsultation'] = countOfConsultation;
    map['isBookmark'] = isBookmark;
    map['rate'] = rate;
    map['avatar'] = avatar?.toMap();

    return map;
  }
}
