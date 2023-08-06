// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 2;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      uuid: fields[0] as String,
      pill: fields[1] as PillModel,
      date: fields[2] as DateTime,
      selectDayList: (fields[3] as List?)?.cast<DateTime>(),
      repeatDay: fields[4] as int?,
      isTake: fields[5] as bool?,
      isSnooze: fields[6] as bool?,
      isSkip: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.pill)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.selectDayList)
      ..writeByte(4)
      ..write(obj.repeatDay)
      ..writeByte(5)
      ..write(obj.isTake)
      ..writeByte(6)
      ..write(obj.isSnooze)
      ..writeByte(7)
      ..write(obj.isSkip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
