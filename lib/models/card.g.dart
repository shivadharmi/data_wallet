// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardAdapter extends TypeAdapter<Card> {
  @override
  final int typeId = 1;

  @override
  Card read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Card(
      cardNickName: fields[0] as String,
      nameOnCard: fields[1] as String,
      cardNumber: fields[2] as String,
      valid: fields[3] as String,
      cvv: fields[4] as String,
      id: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Card obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.cardNickName)
      ..writeByte(1)
      ..write(obj.nameOnCard)
      ..writeByte(2)
      ..write(obj.cardNumber)
      ..writeByte(3)
      ..write(obj.valid)
      ..writeByte(4)
      ..write(obj.cvv)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
