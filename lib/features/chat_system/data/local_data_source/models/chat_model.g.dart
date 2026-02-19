// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatModelAdapter extends TypeAdapter<ChatModel> {
  @override
  final int typeId = 1;

  @override
  ChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatModel(
      id: fields[0] as String,
      bookingId: fields[1] as String,
      customerId: fields[2] as String,
      providerId: fields[3] as String,
      serviceName: fields[4] as String,
      lastMessage: fields[5] as String?,
      lastMessageTimeMillis: fields[6] as int?,
      customerUnreadCount: fields[7] as int,
      providerUnreadCount: fields[8] as int,
      createdAtMillis: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bookingId)
      ..writeByte(2)
      ..write(obj.customerId)
      ..writeByte(3)
      ..write(obj.providerId)
      ..writeByte(4)
      ..write(obj.serviceName)
      ..writeByte(5)
      ..write(obj.lastMessage)
      ..writeByte(6)
      ..write(obj.lastMessageTimeMillis)
      ..writeByte(7)
      ..write(obj.customerUnreadCount)
      ..writeByte(8)
      ..write(obj.providerUnreadCount)
      ..writeByte(9)
      ..write(obj.createdAtMillis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
