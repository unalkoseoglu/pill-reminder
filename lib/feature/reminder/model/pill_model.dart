import 'package:hive_flutter/hive_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:pill_reminder/product/utility/database/core/hive_types.dart';

part 'pill_model.g.dart';

@HiveType(typeId: HiveTypes.pillModelHiveType)
class PillModel with EquatableMixin {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? note;
  @HiveField(3)
  final String? amount;
  @HiveField(4)
  final String? image;
  PillModel({
    this.id,
    this.name,
    this.note,
    this.amount,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, note, amount, image];

  PillModel copyWith({
    int? id,
    String? name,
    String? note,
    String? amount,
    String? image,
  }) {
    return PillModel(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      amount: amount ?? this.amount,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'amount': amount,
      'image': image,
    };
  }
}
