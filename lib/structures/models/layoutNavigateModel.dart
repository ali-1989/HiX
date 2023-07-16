
class LayoutNavigateModel {
  int index = 0;
  String title = '';
  String iconAddress = '';
  bool isSelected = false;

  LayoutNavigateModel();

  LayoutNavigateModel.fromMap(Map map) {
    title = map['title']?? '';
    index = map['index']?? '';
    iconAddress = map['iconAddress']?? '';
    isSelected = map['isSelected']?? false;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['index'] = index;
    map['title'] = title;
    map['iconAddress'] = iconAddress;
    map['isSelected'] = isSelected;

    return map;
  }
}
