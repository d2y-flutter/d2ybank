import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();
  @override DateTime fromJson(String json) => DateTime.parse(json);
  @override String toJson(DateTime object) => object.toIso8601String();
}

class NullableDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const NullableDateTimeConverter();
  @override DateTime? fromJson(String? json) => json != null ? DateTime.tryParse(json) : null;
  @override String? toJson(DateTime? object) => object?.toIso8601String();
}

class BoolIntConverter implements JsonConverter<bool, dynamic> {
  const BoolIntConverter();
  @override bool fromJson(dynamic json) => json == 1 || json == true || json == '1';
  @override dynamic toJson(bool object) => object ? 1 : 0;
}
