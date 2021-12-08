import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));
String chatToJson(Chat data)=> json.encode(data.toJson());

class Chat {
    String username;
    String chat;
    Chat({
      required this.username,
      required this.chat,
    });
    factory Chat.fromJson(Map<String, dynamic> json) => Chat(username: json["username"], chat: json["chat"]);

    Map<String, dynamic> toJson() => {
      "username": username,
      "chat": chat,
    };
}