import 'package:hive_flutter/hive_flutter.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';

import 'package:equatable/equatable.dart';
import 'package:pill_reminder/product/utility/database/core/hive_types.dart';
import 'package:pill_reminder/product/utility/database/model/hive_model.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: HiveTypes.reminderModelHiveType)
class ReminderModel with EquatableMixin, HiveModelMixin {
  @HiveField(0)
  String? uuid;
  @HiveField(1)
  PillModel? pill;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  List<DateTime>? selectDayList;
  @HiveField(4)
  int? repeatDay;
  @HiveField(5)
  bool? isTake;
  @HiveField(6)
  bool? isSnooze;
  @HiveField(7)
  bool? isSkip;

  ReminderModel({
    this.uuid,
    this.pill,
    this.date,
    this.selectDayList,
    this.repeatDay,
    this.isTake,
    this.isSnooze,
    this.isSkip,
  });

  @override
  List<Object?> get props =>
      [uuid, pill, date, selectDayList, repeatDay, isTake, isSnooze, isSkip];
  static const String userKey = 'user';

  @override
  // Model unique key
  String get key => userKey;

  ReminderModel copyWith({
    String? uuid,
    PillModel? pill,
    DateTime? date,
    List<DateTime>? selectDayList,
    int? repeatDay,
    bool? isTake,
    bool? isSnooze,
    bool? isSkip,
  }) {
    return ReminderModel(
      uuid: uuid ?? this.uuid,
      pill: pill ?? this.pill,
      date: date ?? this.date,
      selectDayList: selectDayList ?? this.selectDayList,
      repeatDay: repeatDay ?? this.repeatDay,
      isTake: isTake ?? this.isTake,
      isSnooze: isSnooze ?? this.isSnooze,
      isSkip: isSkip ?? this.isSkip,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'pill': pill,
      'date': date,
      'selectDayList': selectDayList,
      'repeatDay': repeatDay,
      'isTake': isTake,
      'isSnooze': isSnooze,
      'isSkip': isSkip,
    };
  }
}
