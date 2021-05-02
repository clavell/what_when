import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'TaskModel.g.dart';

abstract class TaskModel implements Built<TaskModel, TaskModelBuilder> {
  static Serializer<TaskModel> get serializer => _$taskModelSerializer;

  int get id;
  @nullable
  int get parent;

  @nullable
  BuiltList<int> get prereqs;

  String get title;

  bool get complete;

  TaskModel._();
  factory TaskModel([void Function(TaskModelBuilder) updates]) = _$TaskModel;
}
//
// class TaskModel {
//   int _id;
//   String _title;
//   int _parent;
//   List<int> _prereqs;
//
//   TaskModel(this._id, this._title, this._parent, this._prereqs);
//
//   int get id => _id;
//
//   int get parent => _parent;
//
//   List<int> get prereqs => _prereqs;
//
//   String get title => _title;
// }
