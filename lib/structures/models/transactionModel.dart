import 'package:iris_tools/dateSection/dateHelper.dart';

class TransactionModel {
  String title = '';
  late DateTime date;
  String factorNumber = '0';
  int amount = 0;

  TransactionModel();

  TransactionModel.fromMap(Map map) {
    title = map['title']?? '';
    amount = map['amount']?? 0;
    factorNumber = map['factorNumber'];
    date = DateHelper.tsToSystemDate(map['date'])!;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['title'] = title;
    map['amount'] = amount;
    map['factorNumber'] = factorNumber;
    map['date'] = date;

    return map;
  }

  bool isPlus(){
    return amount > 0;
  }
}
