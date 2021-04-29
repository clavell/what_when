// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskModel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TaskModel> _$taskModelSerializer = new _$TaskModelSerializer();

class _$TaskModelSerializer implements StructuredSerializer<TaskModel> {
  @override
  final Iterable<Type> types = const [TaskModel, _$TaskModel];
  @override
  final String wireName = 'TaskModel';

  @override
  Iterable<Object> serialize(Serializers serializers, TaskModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.parent;
    if (value != null) {
      result
        ..add('parent')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.prereqs;
    if (value != null) {
      result
        ..add('prereqs')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.complete;
    if (value != null) {
      result
        ..add('complete')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  TaskModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TaskModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'parent':
          result.parent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'prereqs':
          result.prereqs.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'complete':
          result.complete = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$TaskModel extends TaskModel {
  @override
  final int id;
  @override
  final int parent;
  @override
  final BuiltList<int> prereqs;
  @override
  final String title;
  @override
  final bool complete;

  factory _$TaskModel([void Function(TaskModelBuilder) updates]) =>
      (new TaskModelBuilder()..update(updates)).build();

  _$TaskModel._({this.id, this.parent, this.prereqs, this.title, this.complete})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'TaskModel', 'id');
    BuiltValueNullFieldError.checkNotNull(title, 'TaskModel', 'title');
  }

  @override
  TaskModel rebuild(void Function(TaskModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TaskModelBuilder toBuilder() => new TaskModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TaskModel &&
        id == other.id &&
        parent == other.parent &&
        prereqs == other.prereqs &&
        title == other.title &&
        complete == other.complete;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), parent.hashCode), prereqs.hashCode),
            title.hashCode),
        complete.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TaskModel')
          ..add('id', id)
          ..add('parent', parent)
          ..add('prereqs', prereqs)
          ..add('title', title)
          ..add('complete', complete))
        .toString();
  }
}

class TaskModelBuilder implements Builder<TaskModel, TaskModelBuilder> {
  _$TaskModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _parent;
  int get parent => _$this._parent;
  set parent(int parent) => _$this._parent = parent;

  ListBuilder<int> _prereqs;
  ListBuilder<int> get prereqs => _$this._prereqs ??= new ListBuilder<int>();
  set prereqs(ListBuilder<int> prereqs) => _$this._prereqs = prereqs;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  bool _complete;
  bool get complete => _$this._complete;
  set complete(bool complete) => _$this._complete = complete;

  TaskModelBuilder();

  TaskModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _parent = $v.parent;
      _prereqs = $v.prereqs?.toBuilder();
      _title = $v.title;
      _complete = $v.complete;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TaskModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TaskModel;
  }

  @override
  void update(void Function(TaskModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TaskModel build() {
    _$TaskModel _$result;
    try {
      _$result = _$v ??
          new _$TaskModel._(
              id: BuiltValueNullFieldError.checkNotNull(id, 'TaskModel', 'id'),
              parent: parent,
              prereqs: _prereqs?.build(),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, 'TaskModel', 'title'),
              complete: complete);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'prereqs';
        _prereqs?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TaskModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
