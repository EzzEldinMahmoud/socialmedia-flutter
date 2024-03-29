class MessageModel{
  String? senderId;
  String? recieverId;
  String? image;
  String? datetime;
  String? text;



  MessageModel({
    required this.recieverId,
    required this.datetime,
    required this.senderId,
    required this.image,
    required this.text,

  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime']?? '';
    image = json['image']?? '';
    text = json['text']?? '';
    senderId = json['senderId']?? '';
    recieverId = json['recieverId']?? '';

  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'datetime': datetime,
      'text': text,
      'senderId': senderId,
      'recieverId': recieverId,

    };
  }
}