enum UserType {
  guest(0),
  common(1),
  admin(9);

  final int _type;

  const UserType(this._type);

  factory UserType.from(dynamic numberOrString){
    if(numberOrString is String){
      return values.firstWhere((element) => element.name == numberOrString, orElse: ()=> common);
    }

    if(numberOrString is int){
      return values.firstWhere((element) => element._type == numberOrString, orElse: ()=> common);
    }

    return UserType.common;
  }

  int type(){
    return _type;
  }
}