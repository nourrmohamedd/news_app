import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  const CategoryModel({required this.id, required this.imageKey});

  final String id;

  final String imageKey;

  @override
  List<Object?> get props => [id, imageKey];
}
