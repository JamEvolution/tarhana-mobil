import 'package:freezed_annotation/freezed_annotation.dart';

part 'tarhana.freezed.dart';
part 'tarhana.g.dart';

@freezed
class Tarhana with _$Tarhana {
  const factory Tarhana({
    required String id,
    required String name,
    required String description,
    required List<String> ingredients,
    required List<String> steps,
    required String imageUrl,
    required String authorId,
    required DateTime createdAt,
    @Default(0) int likes,
    @Default(false) bool isFavorite,
  }) = _Tarhana;

  factory Tarhana.fromJson(Map<String, dynamic> json) => _$TarhanaFromJson(json);
} 