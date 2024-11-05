// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String guid;
  final String name;
  final String iconUrl;

  const CategoryEntity(
      {required this.guid, required this.name, required this.iconUrl});

  @override
  List<Object?> get props => [guid, name, iconUrl];
}
