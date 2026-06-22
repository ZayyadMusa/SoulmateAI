// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoiceProfileAdapter extends TypeAdapter<VoiceProfile> {
  @override
  final int typeId = 2;

  @override
  VoiceProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoiceProfile(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      isSelected: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, VoiceProfile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoiceProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
