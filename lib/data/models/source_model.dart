import 'package:equatable/equatable.dart';

class SourceModel extends Equatable {
  const SourceModel({required this.id, required this.name});

  final String id;
  final String name;

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
  );

  @override
  List<Object?> get props => [id, name];
}
