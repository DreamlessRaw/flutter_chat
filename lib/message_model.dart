class MessageModel {
  String logo;
  String message;
  DateTime dateTime;
  bool isSend; // 是否发送者

  MessageModel(this.logo, this.message, this.dateTime, this.isSend);
}
