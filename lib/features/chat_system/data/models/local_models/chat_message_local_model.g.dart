// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageLocalModelAdapter extends TypeAdapter<ChatMessageLocalModel> {
  @override
  final int typeId = 0;

  @override
  ChatMessageLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageLocalModel(
      id: fields[0] as String,
      chatId: fields[1] as String,
      senderId: fields[2] as String,
      text: fields[3] as String,
      type: fields[4] as String,
      isRead: fields[5] as bool,
      createdAtMillis: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageLocalModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chatId)
      ..writeByte(2)
      ..write(obj.senderId)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.isRead)
      ..writeByte(6)
      ..write(obj.createdAtMillis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
