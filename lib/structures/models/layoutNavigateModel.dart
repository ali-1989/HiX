
class LayoutNavigateModel {
  String enTitle = '';
  String title = '';
  String iconAddress = '';
  bool isSelected = false;

  LayoutNavigateModel();

  LayoutNavigateModel.fromMap(Map map) {
    title = map['title']?? '';
    enTitle = map['enTitle']?? '';
    iconAddress = map['iconAddress']?? '';
    isSelected = map['isSelected']?? false;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['enTitle'] = enTitle;
    map['title'] = title;
    map['iconAddress'] = iconAddress;
    map['isSelected'] = isSelected;

    return map;
  }
}
