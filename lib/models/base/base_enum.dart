abstract class BaseEnum {
  final int _id;
  final String _name;

  const BaseEnum(this._id, this._name);

  int get id => _id;

  String get name => _name;
}
