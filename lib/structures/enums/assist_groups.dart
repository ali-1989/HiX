import 'package:iris_tools/modules/stateManagers/assist.dart';
import 'package:iris_tools/modules/stateManagers/updater_state.dart';

enum AssistGroup implements GroupId {
  updateAudioSeen(100);

  final int _number;

  const AssistGroup(this._number);

  int getNumber(){
    return _number;
  }
}
///==============================================================================
enum BadgesGroup implements UpdaterGroupId {
  notification(100),
  ww(101),
  ss(102);

  final int _number;

  const BadgesGroup(this._number);

  int getNumber(){
    return _number;
  }
}