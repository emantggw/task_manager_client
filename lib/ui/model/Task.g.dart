// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      cratedAt: json['cratedAt'] == null
          ? null
          : DateTime.parse(json['cratedAt'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'cratedAt': instance.cratedAt?.toIso8601String(),
      'id': instance.id,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.active: 'active',
  TaskStatus.done: 'done',
};
