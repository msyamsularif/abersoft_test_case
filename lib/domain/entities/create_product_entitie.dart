import 'package:equatable/equatable.dart';

class CreateProductEntitie extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String desc;

  const CreateProductEntitie({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.desc,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, desc];
}
