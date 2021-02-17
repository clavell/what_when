class TaskModel {
  int _id;
  String _title;
  int? _parent;
  List<int>? _prereqs;

  TaskModel(this._id, this._title, this._parent, this._prereqs);

  int get id => _id;

  int? get parent => _parent;

  List<int>? get prereqs => _prereqs;

  String get title => _title;
}
