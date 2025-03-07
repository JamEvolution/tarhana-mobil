// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarhana.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TarhanaImpl _$$TarhanaImplFromJson(Map<String, dynamic> json) =>
    _$TarhanaImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      authorId: json['authorId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$TarhanaImplToJson(_$TarhanaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'imageUrl': instance.imageUrl,
      'authorId': instance.authorId,
      'createdAt': instance.createdAt.toIso8601String(),
      'likes': instance.likes,
      'isFavorite': instance.isFavorite,
    };
