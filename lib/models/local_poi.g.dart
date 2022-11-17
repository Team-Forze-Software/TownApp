// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_poi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalPOIAdapter extends TypeAdapter<LocalPOI> {
  @override
  final int typeId = 0;

  @override
  LocalPOI read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalPOI()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..description = fields[2] as String?
      ..photoUrl = fields[3] as String?
      ..punctuation = fields[4] as int?;
  }

  @override
  void write(BinaryWriter writer, LocalPOI obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.photoUrl)
      ..writeByte(4)
      ..write(obj.punctuation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalPOIAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
